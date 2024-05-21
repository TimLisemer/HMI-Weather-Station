#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qthread.h>
#include <iostream>
#include <wiringPi.h>

#define PIN_LSENSOR 4

int main(int argc, char *argv[])
{
    wiringPiSetupGpio();
    pinMode(PIN_LSENSOR, OUTPUT);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    while (true) {
        if (digitalRead(PIN_LSENSOR) == LOW){
            std::cout<<"LOW!"<<std::endl;
        }
        else {
            std::cout<<"HIGH!"<<std::endl;
        }
        QThread::msleep(10);
    }

    return app.exec();
}
