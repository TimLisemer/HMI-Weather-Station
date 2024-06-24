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
    Q_PROPERTY(QString homeDisplayText READ homeDisplayText NOTIFY displayTextChanged)
    Q_PROPERTY(QString lightDisplayText READ lightDisplayText NOTIFY displayTextChanged)
    Q_PROPERTY(QString timeDisplayText READ timeDisplayText NOTIFY displayTextChanged)
    Q_PROPERTY(QString humidityDisplayText READ humidityDisplayText NOTIFY displayTextChanged)
    Q_PROPERTY(QString pressureDisplayText READ pressureDisplayText NOTIFY displayTextChanged)
    Q_PROPERTY(QString tempDisplayText READ tempDisplayText NOTIFY displayTextChanged)

public:
    explicit SensorReader(QObject *parent = nullptr);

    int sensorValue() const;
    QString berlinTime() const;
    QString utcTime() const;
    QString ipAddress() const;
    QString hostname() const;
    QString homeDisplayText() const;
    QString lightDisplayText() const;
    QString timeDisplayText() const;
    QString humidityDisplayText() const;
    QString pressureDisplayText() const;
    QString tempDisplayText() const;

signals:
    void sensorValueChanged();
    void berlinTimeChanged();
    void utcTimeChanged();
    void ipAddressChanged();
    void hostnameChanged();
    void displayTextChanged();

public slots:
    void updateSensorValue();
    void updateDateTime();
    void updateNetworkInfo();
    void updateDisplayTexts();

private:
    int m_sensorValue;
    QTimer m_timer;
    QTimer m_timeTimer;
    QTimeZone m_berlinTimeZone;
    QString m_ipAddress;
    QString m_hostname;
    QString m_humidity;
    QString m_pressure;
    QString m_temp;
    int bme280id;
};

#endif // SENSORREADER_H
