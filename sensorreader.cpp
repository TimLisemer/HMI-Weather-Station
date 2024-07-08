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

/*
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
*/

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
    //return QString("Light Sensor: %1").arg(m_sensorValue);
    return QString("%1").arg(m_sensorValue);
}

QString SensorReader::timeDisplayText() const
{
    return QString("Berlin Time: %1\nUTC Time: %2").arg(berlinTime()).arg(utcTime());
}

QString SensorReader::humidityDisplayText() const
{
    //return QString("Humidity: %1").arg(m_humidity);
    return QString("%1").arg(m_humidity);
}

QString SensorReader::pressureDisplayText() const
{
    //return QString("Air Pressure: %1 hPa").arg(m_pressure);
    return QString("%1 hPa").arg(m_pressure);
}

QString SensorReader::tempDisplayText() const
{
    //return QString("Temperature: %1°C").arg(m_temp);
    return QString("%1°C").arg(m_temp);
}
QList <float> SensorReader::historicTemps() const{
    return m_historicTemps;
}

QList <float> SensorReader::historicHums() const{
    return m_historicHums;
}

QList <float> SensorReader::historicPress() const{
    return m_historicPress;
}
float round(float var)
{
    // 37.66666 * 100 =3766.66
    // 3766.66 + .5 =3767.16    for rounding off value
    // then type cast to int so value is 3767
    // then divided by 100 so the value converted into 37.67
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

    if(historicCounter<10){
        historicCounter++;
    }else{
        m_historicTemps.append(round(compensateTemperature(t_fine)));
        m_historicPress.append(round(compensatePressure(raw.pressure, &cal, t_fine)));
        m_historicHums.append(round(compensateHumidity(raw.humidity, &cal, t_fine)));

        historicCounter=0;

        if (m_historicTemps.length()>18000){
            m_historicTemps.pop_front();
            m_historicPress.pop_front();
            m_historicHums.pop_front();
        }
    }


    m_temp.setNum(round(compensateTemperature(t_fine))); //Celsius
    m_pressure.setNum(round(compensatePressure(raw.pressure, &cal, t_fine))); //hpa
    m_humidity.setNum(round(compensateHumidity(raw.humidity, &cal, t_fine))); //%

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
