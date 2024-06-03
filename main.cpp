#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "sensorreader.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    SensorReader sensorReader;
    engine.rootContext()->setContextProperty("sensorReader", &sensorReader);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
/*
#include <iostream>
#include <wiringPi.h>
#include <libusb-1.0/libusb.h>

#define VENDOR_ID  0x0810  // Ersetze durch deine Vendor ID
#define PRODUCT_ID 0xe501  // Ersetze durch deine Product ID

int main() {
    libusb_device_handle *handle;
    libusb_context *ctx = NULL;
    int rc;

    // Initialisiere libusb
    rc = libusb_init(&ctx); // -lusb-1.0?
    if (rc < 0) {
        std::cerr << "Libusb Init Error " << rc << std::endl;
        return 1;
    }

    // Öffne das USB-Gerät
    handle = libusb_open_device_with_vid_pid(ctx, VENDOR_ID, PRODUCT_ID);
    if (handle == NULL) {
        std::cerr << "Cannot open device" << std::endl;
        libusb_exit(ctx);
        return 1;
    }

    // Falls nötig, Kernel-Treiber abkoppeln
    if (libusb_kernel_driver_active(handle, 0) == 1) {
        std::cout << "Kernel Driver Active" << std::endl;
        if (libusb_detach_kernel_driver(handle, 0) == 0) {
            std::cout << "Kernel Driver Detached!" << std::endl;
        }
    }

    // Konfiguriere das Gerät
    rc = libusb_claim_interface(handle, 0);
    if (rc < 0) {
        std::cerr << "Cannot Claim Interface" << std::endl;
        libusb_close(handle);
        libusb_exit(ctx);
        return 1;
    }

    unsigned char data[64];
    int actual_length;

    // Daten lesen
    while (true) {
        rc = libusb_interrupt_transfer(handle, LIBUSB_ENDPOINT_IN | 1, data, sizeof(data), &actual_length, 0);
        if (rc == 0 && actual_length > 0) {
            std::cout << "Received Data: ";
            for (int i = 0; i < actual_length; ++i) {
                std::cout << std::hex << (int)data[i] << " ";
            }
            std::cout << std::dec << std::endl; // Wechsel zurück zu Dezimalanzeige
        } else {
            std::cerr << "Error in transfer: " << libusb_error_name(rc) << std::endl;
        }
        delay(1000); // Warte 1 Sekunde
    }

    // Schnittstelle und Gerät freigeben
    libusb_release_interface(handle, 0);
    libusb_close(handle);
    libusb_exit(ctx);

    return 0;
}*/
