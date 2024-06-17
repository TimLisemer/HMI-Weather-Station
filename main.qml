import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Sensor Reader")
    color: "#454545" // Background color

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
        state: "Home"
        id: main_column

        // Define states for each dzisplay mode
        states: [
            State {
                name: "Home"
                PropertyChanges { target: displayText; text: "Light Sensor: " + sensorReader.sensorValue
                                    + "\n" +"Berlin Time: " + sensorReader.berlinTime + "\n" + "UTC Time: " + sensorReader.utcTime
                                    + "\n" +"Humidity: " + sensorReader.humidity
                                    + "\n" +"Air Pressure: " + sensorReader.pressure + " hPa"
                                    + "\n" +"Temperature: " + sensorReader.temp + "°C" }
                PropertyChanges { target: displayText; color: "white" }
                PropertyChanges { target: displayImage; visible: false }
            },
            State {
                name: "Light"
                PropertyChanges { target: displayText; text: "Light Sensor: " + sensorReader.sensorValue }
                PropertyChanges { target: displayText; color: "Yellow" }
                PropertyChanges { target: displayImage; visible: true }
            },
            State {
                name: "Time"
                PropertyChanges { target: displayText; text: "Berlin Time: " + sensorReader.berlinTime + "\n UTC Time: " + sensorReader.utcTime }
                PropertyChanges { target: displayText; color: "white" }
                PropertyChanges { target: displayImage; visible: false }
            },
            State {
                name: "Humidity"
                PropertyChanges { target: displayText; text: "Humidity: " + sensorReader.humidity }
                PropertyChanges { target: displayText; color: "white" }
                PropertyChanges { target: displayImage; visible: false }
            },
            State {
                name: "Pressure"
                PropertyChanges { target: displayText; text: "Air Pressure: " + sensorReader.pressure + " hPa" }
                PropertyChanges { target: displayText; color: "white" }
                PropertyChanges { target: displayImage; visible: false }
            },
            State {
                name: "Temp"
                PropertyChanges { target: displayText; text: "Temperature: " + sensorReader.temp + "°C" }
                PropertyChanges { target: displayText; color: "white" }
                PropertyChanges { target: displayImage; visible: false }
            }
        ]

        // Row for buttons at the top
        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                id: homeButton
                width: 40
                height: light_button.height
                onClicked: main_column.state = "Home"
                contentItem: Image {
                    source: "../img/homebutton.png"
                    fillMode: Image.PreserveAspectFit
                    width: 40
                    height: 40
                }
            }

            Button {
                id: light_button
                text: "Light"
                onClicked: main_column.state = "Light"
            }

            Button {
                id: time_button
                text: "Time"
                onClicked: main_column.state = "Time"
            }

            Button {
                id: humidity_button
                text: "Humidity"
                onClicked: main_column.state = "Humidity"
            }

            Button {
                id: pressure_button
                text: "Pressure"
                onClicked: main_column.state = "Pressure"
            }

            Button {
                id: temperature_button
                text: "Temp"
                onClicked: main_column.state = "Temp"
            }
        }

        // Text in the middle
        Text {
            id: displayText
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: digitalFont.name
            font.pointSize: 30
            color: "white" // Default color
            text: "Select an option" // Default text

        }
    }

    // Image in the center of the screen
    Image {
        id: displayImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: false // Default visibility
        width: 200  // Larger width
        height: 200 // Larger height
        source: sensorReader.sensorValue ? "../img/Moon.png" : "../img/Sun.png"
    }
}
