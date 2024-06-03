import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Sensor Reader")
    color: "#454545"

    Image {
        visible: sensorReader.sensorValue > 0
        x: 40
        y: 40
        scale: 0.3
        id: sun
        source: "../img/Sun.png"
    }

    Image {
        visible: sensorReader.sensorValue < 1
        x: 50
        y: 50
        scale: 0.3
        id: moon
        source: "../img/Moon.png"
    }

    Column {
        anchors.centerIn: parent

        Text {
            text: "Light Sensor: " + sensorReader.sensorValue
            color: "Yellow"
            font.pointSize: 24
        }


        Text {
            text: "Berlin Time: " + sensorReader.berlinTime
            color: "white"
            font.pointSize: 24
        }

        Text {
            text: "UTC Time: " + sensorReader.utcTime
            color: "white"
            font.pointSize: 24
        }

        Text {
            text: "IP Address: " + sensorReader.ipAddress
            color: "white"
            font.pointSize: 24
        }

        Text {
            text: "Hostname: " + sensorReader.hostname
            color: "white"
            font.pointSize: 24
        }
    }
}
