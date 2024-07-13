import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Sensor Reader")
    color: "#454545" // Background color
    property bool showHumidityChart: true
    property bool showPressureChart: true
    property bool showTemperatureChart: true

    FontLoader {
        id: digitalFont
        source: "qrc:/font/DS-DIGI.TTF"
    }

    // Globale Schriftarteigenschaften festlegen
    font.family: digitalFont.name
    font.pointSize: 24

    // Header Row with Navigation Buttons
    Row {
        id: button_row
        width: childrenRect.width  // Use the width of the children
        height: 60
        spacing: 10
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter // Center the Row horizontally

        Button {
            id: homeButton
            width: 45
            height: 45
            onClicked: stackView.push("HomeScreen.qml")
            contentItem: Image {
                source: "../img/homebutton.png"
                fillMode: Image.PreserveAspectFit
                width: 45
                height: 45
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
            onClicked: {
                stackView.push("HumidityScreen.qml")
                showHumidityChart = !showHumidityChart;
            }
        }

        Button {
            id: pressureButton
            text: "Pressure"
            onClicked: {
                stackView.push("PressureScreen.qml")
                showPressureChart = !showPressureChart;
            }
        }

        Button {
            id: temperatureButton
            text: "Temperature"
            onClicked: {
                stackView.push("TemperatureScreen.qml")
                showTemperatureChart = !showTemperatureChart;
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.topMargin: 60 // Leave space for the header
        initialItem: "HomeScreen.qml"
    }
}
