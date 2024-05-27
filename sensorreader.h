#ifndef SENSORREADER_H
#define SENSORREADER_H

#include <QObject>
#include <QTimer>
#include <QDateTime>
#include <QTimeZone>
#include <wiringPi.h>

class SensorReader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int sensorValue READ sensorValue NOTIFY sensorValueChanged)
    Q_PROPERTY(QString berlinTime READ berlinTime NOTIFY berlinTimeChanged)
    Q_PROPERTY(QString utcTime READ utcTime NOTIFY utcTimeChanged)
    Q_PROPERTY(QString ipAddress READ ipAddress NOTIFY ipAddressChanged)
    Q_PROPERTY(QString hostname READ hostname NOTIFY hostnameChanged)

public:
    explicit SensorReader(QObject *parent = nullptr);

    int sensorValue() const;
    QString berlinTime() const;
    QString utcTime() const;
    QString ipAddress() const;
    QString hostname() const;

signals:
    void sensorValueChanged();
    void berlinTimeChanged();
    void utcTimeChanged();
    void ipAddressChanged();
    void hostnameChanged();

public slots:
    void updateSensorValue();
    void updateDateTime();
    void updateNetworkInfo();

private:
    int m_sensorValue;
    QTimer m_timer;
    QTimer m_timeTimer;
    QTimeZone m_berlinTimeZone;
    QString m_ipAddress;
    QString m_hostname;
};

#endif // SENSORREADER_H
