#include "sensorreader.h"
#include <QNetworkInterface>
#include <QHostInfo>
#include <QProcess>
#include <QTextStream>
#include <QFile>

#define PIN_LSENSOR 4

SensorReader::SensorReader(QObject *parent)
    : QObject(parent), m_sensorValue(0), m_berlinTimeZone("Europe/Berlin")
{
    wiringPiSetup();
    pinMode(PIN_LSENSOR, INPUT);

    connect(&m_timer, &QTimer::timeout, this, &SensorReader::updateSensorValue);
    m_timer.start(10); // 10 ms interval

    connect(&m_timeTimer, &QTimer::timeout, this, &SensorReader::updateDateTime);
    m_timeTimer.start(1000); // 1 second interval

    updateNetworkInfo();
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

void SensorReader::updateSensorValue()
{
    int value = digitalRead(PIN_LSENSOR);
    if (value != m_sensorValue) {
        m_sensorValue = value;
        emit sensorValueChanged();
    }
}

void SensorReader::updateDateTime()
{
    emit berlinTimeChanged();
    emit utcTimeChanged();
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
