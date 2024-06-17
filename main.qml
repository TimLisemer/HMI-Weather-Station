import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Sensor Reader")
    color: "#454545" // Farbe für Hintergrund

    FontLoader {
        id: digitalFont
        source: "qrc:/font/DS-DIGI.TTF"
    }

    // Globale Schriftarteigenschaften festlegen
    font.family: digitalFont.name
    font.pointSize: 24

    Column {
        width: parent.width
        spacing: 20

        // Row für die Buttons ganz oben
        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                id: homeButton
                width: 40
                height: 40
                onClicked: displayMode = "Home"
                contentItem: Image {
                    source: "../img/homebutton.png"
                    fillMode: Image.PreserveAspectFit
                    width: 40
                    height: 40
                }
            }

            Button {
                text: "Light"
                onClicked: displayMode = "Light"
            }

            Button {
                text: "Time"
                onClicked: displayMode = "Time"
            }

            Button {
                text: "Humidity"
                onClicked: displayMode = "Humidity"
            }

            Button {
                text: "Pressure"
                onClicked: displayMode = "Pressure"
            }

            Button {
                text: "Temp"
                onClicked: displayMode = "Temp"
            }
        }

        // Text in der Mitte
        Text {
            id: displayText
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: digitalFont.name
            font.pointSize: 30

            text: {
                switch (displayMode) {
                    case "Home":
                        return "Light Sensor: " + sensorReader.sensorValue
                                + "\n" +"Berlin Time: " + sensorReader.berlinTime + "\n" + "UTC Time: " + sensorReader.utcTime
                                + "\n" +"Humidity: " + sensorReader.humidity
                                + "\n" +"Air Pressure: " + sensorReader.pressure + " hPa"
                                + "\n" +"Temperature: " + sensorReader.temp + "°C"
                    case "Light":
                        return "Light Sensor: " + sensorReader.sensorValue
                    case "Time":
                        return "Berlin Time: " + sensorReader.berlinTime + "\n UTC Time: " + sensorReader.utcTime
                    case "Humidity":
                        return "Humidity: " + sensorReader.humidity
                    case "Pressure":
                        return "Air Pressure: " + sensorReader.pressure + " hPa"
                    case "Temp":
                        return "Temperature: " + sensorReader.temp + "°C"
                    default:
                        return "Select an option"
                }
            }

            color: {
                switch (displayMode) {
                    case "Light":
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
        visible: displayMode == "Light"
        width: 200  // Größere Breite
        height: 200 // Größere Höhe
        source: sensorReader.sensorValue ? "../img/Moon.png" : "../img/Sun.png"
    }

    // Property für die Anzeigeauswahl
    property string displayMode: "Home"
}
