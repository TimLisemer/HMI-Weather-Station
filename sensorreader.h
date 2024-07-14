#ifndef SENSORREADER_H
#define SENSORREADER_H

#include <QObject>
#include <QTimer>
#include <QDateTime>
#include <QTimeZone>
#include <wiringPi.h>
#include <QList>

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

    Q_PROPERTY(QList <float> historicTemps READ historicTemps NOTIFY sensorValueChanged)
    Q_PROPERTY(QList <float> historicHums READ historicHums NOTIFY sensorValueChanged)
    Q_PROPERTY(QList <float> historicPress READ historicPress NOTIFY sensorValueChanged)

    Q_PROPERTY(QList <float> chartHistoricTempsData READ chartHistoricTempsData NOTIFY sensorValueChanged)
    Q_PROPERTY(QList <float> chartHistoricPressData READ chartHistoricPressData NOTIFY sensorValueChanged)
    Q_PROPERTY(QList <float> chartHistoricHumsData READ chartHistoricHumsData NOTIFY sensorValueChanged)

    Q_PROPERTY(QStringList historicTempsTimeCategories READ historicTempsTimeCategories NOTIFY sensorValueChanged)
    Q_PROPERTY(QStringList historicHumsTimeCategories READ historicHumsTimeCategories NOTIFY sensorValueChanged)
    Q_PROPERTY(QStringList historicPressTimeCategories READ historicPressTimeCategories NOTIFY sensorValueChanged)

    Q_PROPERTY(QStringList chartHistoricTempsTimeCategories READ chartHistoricTempsTimeCategories NOTIFY sensorValueChanged)
    Q_PROPERTY(QStringList chartHistoricHumsTimeCategories READ chartHistoricHumsTimeCategories NOTIFY sensorValueChanged)
    Q_PROPERTY(QStringList chartHistoricPressTimeCategories READ chartHistoricPressTimeCategories NOTIFY sensorValueChanged)

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

    QList <float> historicTemps() const;
    QList <float> historicHums() const;
    QList <float> historicPress() const;

    QList <float> chartHistoricTempsData() const;
    QList <float> chartHistoricPressData() const;
    QList <float> chartHistoricHumsData() const;


    QStringList historicTempsTimeCategories() const;
    QStringList historicHumsTimeCategories() const;
    QStringList historicPressTimeCategories() const;

    QStringList chartHistoricTempsTimeCategories() const;
    QStringList chartHistoricHumsTimeCategories() const;
    QStringList chartHistoricPressTimeCategories() const;




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
    QList <float> m_historicTemps;
    QList <float> m_historicHums;
    QList <float> m_historicPress;
    QStringList m_humidityTimeCategories;
    QStringList m_pressureTimeCategories;
    QStringList m_tempTimeCategories;
    int historicCounter=0;
    QList<float> averageIntoSlices(const QList<float>& data) const;
    QStringList averageTimesIntoSlices(const QStringList& times) const;
};

#endif // SENSORREADER_H
