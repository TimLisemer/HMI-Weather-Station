#include "sensorreader.h"
#include <QNetworkInterface>
#include <QHostInfo>
#include <QProcess>
#include <QTextStream>
#include <QFile>
#include <bme280.h>
#include <wiringPiI2C.h>
#include <stdio.h>
#include <cmath>
#include <algorithm>

#define PIN_LSENSOR 4

SensorReader::SensorReader(QObject *parent)
    : QObject(parent), m_sensorValue(0), m_berlinTimeZone("Europe/Berlin"), m_humidity("45%"), m_pressure("1013"), m_temp("22.5")
{
    wiringPiSetup();
    pinMode(PIN_LSENSOR, INPUT);

    connect(&m_timer, &QTimer::timeout, this, &SensorReader::updateSensorValue);
    m_timer.start(10); // 10 ms interval

    connect(&m_timeTimer, &QTimer::timeout, this, &SensorReader::updateDateTime);
    m_timeTimer.start(1000); // 1 second interval

    updateNetworkInfo();
    updateDisplayTexts();

    bme280id = setupSensor();
}

int SensorReader::sensorValue() const
{
    return m_sensorValue;
}

QString SensorReader::berlinTime() const
{
    QDateTime currentTime = QDateTime::currentDateTime();
    return currentTime.toTimeZone(m_berlinTimeZone).toString("hh:mm:ss");
}

QString SensorReader::utcTime() const
{
    QDateTime currentTime = QDateTime::currentDateTimeUtc();
    return currentTime.toString("hh:mm:ss");
}

QString SensorReader::ipAddress() const
{
    return m_ipAddress;
}

QString SensorReader::hostname() const
{
    return m_hostname;
}

QString SensorReader::homeDisplayText() const
{
    return QString("Light Sensor: %1\nBerlin Time: %2\nUTC Time: %3\nHumidity: %4\nAir Pressure: %5 hPa\nTemperature: %6°C")
        .arg(m_sensorValue)
        .arg(berlinTime())
        .arg(utcTime())
        .arg(m_humidity)
        .arg(m_pressure)
        .arg(m_temp);
}

QString SensorReader::lightDisplayText() const
{
    return QString("%1").arg(m_sensorValue);
}

QString SensorReader::timeDisplayText() const
{
    return QString("Berlin Time: %1\nUTC Time: %2").arg(berlinTime()).arg(utcTime());
}

QString SensorReader::humidityDisplayText() const
{
    return QString("%1").arg(m_humidity);
}

QString SensorReader::pressureDisplayText() const
{
    return QString("%1 hPa").arg(m_pressure);
}

QString SensorReader::tempDisplayText() const
{
    return QString("%1°C").arg(m_temp);
}

QList<float> SensorReader::historicTemps() const {
    return m_historicTemps;
}

QList<float> SensorReader::historicHums() const {
    return m_historicHums;
}

QList<float> SensorReader::historicPress() const {
    return m_historicPress;
}

QStringList SensorReader::historicTempsTimeCategories() const {
    return m_tempTimeCategories;
}

QStringList SensorReader::historicHumsTimeCategories() const {
    return m_humidityTimeCategories;
}

QStringList SensorReader::historicPressTimeCategories() const {
    return m_pressureTimeCategories;
}


float round(float var)
{
    float value = (int)(var * 100 + .5);
    return (float)value / 100;
}

void SensorReader::updateSensorValue()
{
    bme280_calib_data cal;
    readCalibrationData(bme280id, &cal);

    wiringPiI2CWriteReg8(bme280id, 0xf2, 0x01);   // humidity oversampling x 1
    wiringPiI2CWriteReg8(bme280id, 0xf4, 0x25);   // pressure and temperature oversampling x 1, mode normal

    bme280_raw_data raw;
    getRawData(bme280id, &raw);

    int32_t t_fine = getTemperatureCalibration(&cal, raw.temperature);

    if (historicCounter < 10) {
        historicCounter++;
    } else {
        if (compensateTemperature(t_fine) != 0 && compensatePressure(raw.pressure, &cal, t_fine) != 0 && compensateHumidity(raw.humidity, &cal, t_fine) != 0) {

            QDateTime currentTime = QDateTime::currentDateTime();
            QString currentTimeString = currentTime.toString("hh:mm:ss");

            m_historicTemps.append(compensateTemperature(t_fine));
            m_historicPress.append(compensatePressure(raw.pressure, &cal, t_fine));
            m_historicHums.append(compensateHumidity(raw.humidity, &cal, t_fine));

            m_tempTimeCategories.append(currentTimeString);
            m_pressureTimeCategories.append(currentTimeString);
            m_humidityTimeCategories.append(currentTimeString);

            historicCounter = 0;

            if (m_historicTemps.length() > 180) {
                m_historicTemps.pop_front();
                m_historicPress.pop_front();
                m_historicHums.pop_front();
                m_tempTimeCategories.pop_front();
                m_pressureTimeCategories.pop_front();
                m_humidityTimeCategories.pop_front();
            }
        }
    }

    m_temp.setNum(round(compensateTemperature(t_fine))); // Celsius
    m_pressure.setNum(round(compensatePressure(raw.pressure, &cal, t_fine))); // hpa
    m_humidity.setNum(round(compensateHumidity(raw.humidity, &cal, t_fine))); // %

    int value = !digitalRead(PIN_LSENSOR);
    if (value != m_sensorValue) {
        m_sensorValue = value;
        emit sensorValueChanged();
        emit displayTextChanged();
    }
}

QList<float> SensorReader::chartHistoricTempsData() const {
    return averageIntoSlices(m_historicTemps);
}

QList<float> SensorReader::chartHistoricPressData() const {
    return averageIntoSlices(m_historicPress);
}

QList<float> SensorReader::chartHistoricHumsData() const {
    return averageIntoSlices(m_historicHums);
}

QStringList SensorReader::chartHistoricTempsTimeCategories() const {
    return averageTimesIntoSlices(m_tempTimeCategories);
}

QStringList SensorReader::chartHistoricPressTimeCategories() const {
    return averageTimesIntoSlices(m_pressureTimeCategories);
}

QStringList SensorReader::chartHistoricHumsTimeCategories() const {
    return averageTimesIntoSlices(m_humidityTimeCategories);
}

QList<float> SensorReader::averageIntoSlices(const QList<float>& data) const {
    int count = data.size();
    QList<float> result;
    int combined = 0;
    int sliceSize = std::max(1, count / 5);  // Ensure sliceSize is at least 1 to avoid division by zero

    for (int i = 0; i < count; ++i) {
        combined += data[i];
        if ((i + 1) % sliceSize == 0 || i == count - 1) { // Check end of each segment
            result.append(combined / ((i % sliceSize) + 1)); // Divide sum by number of elements in the current segment
            combined = 0; // Reset combined for next segment
        }
    }

    return result;
}

QStringList SensorReader::averageTimesIntoSlices(const QStringList& times) const {
    int count = times.size();
    QStringList result;
    int sliceSize = count / 5;  // Calculate the approximate size of each slice

    if (sliceSize == 0) {
        // If there are fewer than 5 elements, return all elements as they are
        return times;
    }

    int combinedSeconds = 0;
    int elementsInSlice = 0;

    for (int i = 0; i < count; ++i) {
        QTime time = QTime::fromString(times[i], "hh:mm:ss");
        combinedSeconds += QTime(0, 0, 0).secsTo(time); // Accumulate seconds from start of day

        ++elementsInSlice;

        if ((i + 1) % sliceSize == 0 || i == count - 1) { // Check end of each segment
            int averageSeconds = combinedSeconds / elementsInSlice;
            QTime averageTime(0, 0, 0);
            averageTime = averageTime.addSecs(averageSeconds);
            result.append(averageTime.toString("hh:mm:ss"));
            combinedSeconds = 0; // Reset combinedSeconds for next segment
            elementsInSlice = 0;
        }
    }

    return result;
}

void SensorReader::updateDateTime()
{
    emit berlinTimeChanged();
    emit utcTimeChanged();
    emit displayTextChanged();
}

void SensorReader::updateNetworkInfo()
{
    // Get IP address
    QList<QHostAddress> ipAddressesList = QNetworkInterface::allAddresses();
    for (int i = 0; i < ipAddressesList.size(); ++i) {
        if (ipAddressesList.at(i) != QHostAddress::LocalHost &&
            ipAddressesList.at(i).toIPv4Address()) {
            m_ipAddress = ipAddressesList.at(i).toString();
            break;
        }
    }
    if (m_ipAddress.isEmpty()) {
        m_ipAddress = QHostAddress(QHostAddress::LocalHost).toString();
    }
    emit ipAddressChanged();

    // Get hostname
    m_hostname = QHostInfo::localHostName();
    emit hostnameChanged();
}

void SensorReader::updateDisplayTexts()
{
    emit displayTextChanged();
}
