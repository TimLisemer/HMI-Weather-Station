import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Sensor Reader")
    color: "#454545" // Background color

    // Define a centralized theme
    property color backgroundColor: "#454545"
    property color textColor: "white"
    property color highlightColor: "yellow"
    property int fontSize: 24
    property int buttonWidth: 100
    property int buttonHeight: 40

    FontLoader {
        id: digitalFont
        source: "qrc:/font/DS-DIGI.TTF"
    }

    // Global font properties
    font.family: digitalFont.name
    font.pointSize: fontSize

    Column {
        width: parent.width
        spacing: 20
        id: mainColumn
        state: "Home"

        // Define states for each display mode
        states: [
            State {
                name: "Home"
                PropertyChanges { target: displayText; text: sensorReader.homeDisplayText }
                PropertyChanges { target: displayText; color: textColor }
                PropertyChanges { target: displayImage; visible: false }
            },
            State {
                name: "Light"
                PropertyChanges { target: displayText; text: sensorReader.lightDisplayText }
                PropertyChanges { target: displayText; color: highlightColor }
                PropertyChanges { target: displayImage; visible: true }
            },
            State {
                name: "Time"
                PropertyChanges { target: displayText; text: sensorReader.timeDisplayText }
                PropertyChanges { target: displayText; color: textColor }
                PropertyChanges { target: displayImage; visible: false }
            },
            State {
                name: "Humidity"
                PropertyChanges { target: displayText; text: sensorReader.humidityDisplayText }
                PropertyChanges { target: displayText; color: textColor }
                PropertyChanges { target: displayImage; visible: false }
            },
            State {
                name: "Pressure"
                PropertyChanges { target: displayText; text: sensorReader.pressureDisplayText }
                PropertyChanges { target: displayText; color: textColor }
                PropertyChanges { target: displayImage; visible: false }
            },
            State {
                name: "Temp"
                PropertyChanges { target: displayText; text: sensorReader.tempDisplayText }
                PropertyChanges { target: displayText; color: textColor }
                PropertyChanges { target: displayImage; visible: false }
            }
        ]

        // Row for buttons at the top
        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                width: buttonWidth
                height: buttonHeight
                onClicked: mainColumn.state = "Home"
                contentItem: Image {
                    source: "../img/homebutton.png"
                    fillMode: Image.PreserveAspectFit
                    width: buttonWidth
                    height: buttonHeight
                }
            }

            Button {
                width: buttonWidth
                height: buttonHeight
                text: "Light"
                onClicked: mainColumn.state = "Light"
            }

            Button {
                width: buttonWidth
                height: buttonHeight
                text: "Time"
                onClicked: mainColumn.state = "Time"
            }

            Button {
                width: buttonWidth
                height: buttonHeight
                text: "Humidity"
                onClicked: mainColumn.state = "Humidity"
            }

            Button {
                width: buttonWidth
                height: buttonHeight
                text: "Pressure"
                onClicked: mainColumn.state = "Pressure"
            }

            Button {
                width: buttonWidth
                height: buttonHeight
                text: "Temp"
                onClicked: mainColumn.state = "Temp"
            }
        }

        // Text in the middle
        Text {
            id: displayText
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: digitalFont.name
            font.pointSize: 30
            color: textColor // Default color
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
