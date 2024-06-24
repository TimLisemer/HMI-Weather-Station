#include "sensorreader.h"
#include <QNetworkInterface>
#include <QHostInfo>
#include <QProcess>
#include <QTextStream>
#include <QFile>
#include <bme280.h>
#include <wiringPiI2C.h>
#include <stdio.h>
#include <math.h>
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
    return currentTime.toTimeZone(m_berlinTimeZone).toString("yyyy-MM-dd hh:mm:ss");
}

QString SensorReader::utcTime() const
{
    QDateTime currentTime = QDateTime::currentDateTimeUtc();
    return currentTime.toString("yyyy-MM-dd hh:mm:ss");
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
    return QString("Light Sensor: %1").arg(m_sensorValue);
}

QString SensorReader::timeDisplayText() const
{
    return QString("Berlin Time: %1\nUTC Time: %2").arg(berlinTime()).arg(utcTime());
}

QString SensorReader::humidityDisplayText() const
{
    return QString("Humidity: %1").arg(m_humidity);
}

QString SensorReader::pressureDisplayText() const
{
    return QString("Air Pressure: %1 hPa").arg(m_pressure);
}

QString SensorReader::tempDisplayText() const
{
    return QString("Temperature: %1°C").arg(m_temp);
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

    m_temp.setNum(compensateTemperature(t_fine)); //Celsius
    m_pressure.setNum(compensatePressure(raw.pressure, &cal, t_fine)); //hpa
    m_humidity.setNum(compensateHumidity(raw.humidity, &cal, t_fine)); //%


    int value = digitalRead(PIN_LSENSOR);
    if (value != m_sensorValue) {
        m_sensorValue = value;
        emit sensorValueChanged();
        emit displayTextChanged();
    }
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
