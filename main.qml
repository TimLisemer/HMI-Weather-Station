import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Sensor Reader")
    color: "#454545" // Background color
    //"#454545"

    //property var sensorReader: null

    FontLoader {
        id: digitalFont
        source: "qrc:/font/DS-DIGI.TTF"
    }

    // Globale Schriftarteigenschaften festlegen
    font.family: digitalFont.name
    font.pointSize: 24

    // Header Row with Navigation Buttons
    Row {
        width: parent.width
        height: 60
        spacing: 10
        padding: 10
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter


        Button {
            id: homeButton
            width: 40
            height: 40
            onClicked: stackView.push("HomeScreen.qml")
            contentItem: Image {
                source: "../img/homebutton.png"
                fillMode: Image.PreserveAspectFit
                width: 40
                height: 40
            }
        }

        Button {
            id: lightButton
            text: "Light"
            onClicked: stackView.push("LightSensorScreen.qml")
        }

        Button {
            id: timeButton
            text: "Time"
            onClicked: stackView.push("TimeScreen.qml")
        }

        Button {
            id: humidityButton
            text: "Humidity"
            onClicked: stackView.push("HumidityScreen.qml")
        }

        Button {
            id: pressureButton
            text: "Pressure"
            onClicked: stackView.push("PressureScreen.qml")
        }

        Button {
            id: temperatureButton
            text: "Temperature"
            onClicked: stackView.push("TemperatureScreen.qml")
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.topMargin: 60 // Leave space for the header
        initialItem: "HomeScreen.qml"
    }
}
