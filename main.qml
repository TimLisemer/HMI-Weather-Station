import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

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

    ColumnLayout {
        anchors.fill: parent
        spacing: 20
        id: main_column

        // Row for buttons at the top
        RowLayout {
            spacing: 10
            Layout.alignment: Qt.AlignHCenter

            Button {
                id: homeButton
                width: 40
                height: 40
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
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
                Layout.preferredWidth: 80
                Layout.preferredHeight: 40
                onClicked: main_column.state = "Light"
            }

            Button {
                id: time_button
                text: "Time"
                Layout.preferredWidth: 80
                Layout.preferredHeight: 40
                onClicked: main_column.state = "Time"
            }

            Button {
                id: humidity_button
                text: "Humidity"
                Layout.preferredWidth: 80
                Layout.preferredHeight: 40
                onClicked: main_column.state = "Humidity"
            }

            Button {
                id: pressure_button
                text: "Pressure"
                Layout.preferredWidth: 80
                Layout.preferredHeight: 40
                onClicked: main_column.state = "Pressure"
            }

            Button {
                id: temperature_button
                text: "Temp"
                Layout.preferredWidth: 80
                Layout.preferredHeight: 40
                onClicked: main_column.state = "Temp"
            }
        }

        // Text in the middle for other states
        Text {
            id: displayText
            visible: main_column.state !== "Home"
            Layout.alignment: Qt.AlignHCenter
            font.family: digitalFont.name
            font.pointSize: 30
            color: "white" // Default color
            text: "Select an option" // Default text
        }

        // GridView to cover the entire display
        GridView {
            id: gridView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: objectModell
            delegate: delegateItem

            header: Rectangle {
                width: parent.width
                height: 10
                color: "blue"
            }
            footer: Rectangle {
                width: parent.width
                color: "red"
            }
            highlight: Rectangle {
                width: parent.width
                color: "lightgray"
            }
        }

        // Image in the center of the screen
        Image {
            id: displayImage
            Layout.alignment: Qt.AlignCenter
            visible: main_column.state === "Light"
            width: 200  // Larger width
            height: 200 // Larger height
            source: sensorReader.sensorValue ? "../img/Moon.png" : "../img/Sun.png"
        }
    }

    ListModel {
        id: objectModell
        // Add your list elements here
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
        ListElement { file: "../img/Moon.png"; name: "Time" }
    }

    Component {
        id: delegateItem

        Column {
            Image {
                id: delegateImg
                anchors.horizontalCenter: delegateText.horizontalCenter
                source: file
                width: 64
                height: 64
                smooth: true
                fillMode: Image.PreserveAspectFit
            }
            Text {
                id: delegateText
                text: name
                font.pixelSize: 24
                font.family: digitalFont.name
            }
        }
    }
}
