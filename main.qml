import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Sensor Reader")
    color: "#454545" // Farbe für Hintergrund

    Column {
        width: parent.width
        spacing: 20

        // Row für die Buttons ganz oben
        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                text: "Light Sensor"
                onClicked: displayMode = "LightSensor"
            }

            Button {
                text: "Berlin Time"
                onClicked: displayMode = "BerlinTime"
            }

            Button {
                text: "UTC Time"
                onClicked: displayMode = "UTCTime"
            }

            Button {
                text: "IP Address"
                onClicked: displayMode = "IPAddress"
            }

            Button {
                text: "Hostname"
                onClicked: displayMode = "Hostname"
            }
        }

        // Text in der Mitte
        Text {
            id: displayText
            anchors.horizontalCenter: parent.horizontalCenter
            //color: "white"
            font.pointSize: 24

            text: {
                switch (displayMode) {
                    case "LightSensor":
                        return "Light Sensor: " + sensorReader.sensorValue
                    case "BerlinTime":
                        return "Berlin Time: " + sensorReader.berlinTime
                    case "UTCTime":
                        return "UTC Time: " + sensorReader.utcTime
                    case "IPAddress":
                        return "IP Address: " + sensorReader.ipAddress
                    case "Hostname":
                        return "Hostname: " + sensorReader.hostname
                    default:
                        return "Select an option"
                }
            }

            color: {
                switch (displayMode) {
                    case "LightSensor":
                        return "Yellow"
                    default:
                        return "white"
                }
            }
        }
    }

    // Bild in der Mitte des Bildschirms
    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: displayMode == "LightSensor" && sensorReader.sensorValue < 1
        width: 200  // Größere Breite
        height: 200 // Größere Höhe
        source: "../img/Sun.png"
    }

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: displayMode == "LightSensor" && sensorReader.sensorValue > 0
        width: 200  // Größere Breite
        height: 200 // Größere Höhe
        source: "../img/Moon.png"
    }

    // Property für die Anzeigeauswahl
    property string displayMode: "LightSensor"
}
