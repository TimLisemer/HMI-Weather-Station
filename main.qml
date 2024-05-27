import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Sensor Reader")
    color: "green"

    Column {
        anchors.centerIn: parent

        Text {
            text: "Light Sensor: " + sensorReader.sensorValue
            color: "red"
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
