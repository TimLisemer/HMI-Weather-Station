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

    Column {
        width: parent.width
        spacing: 20
        id: main_column

        // Row for buttons at the top
        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                id: homeButton
                width: 40
                height: 40
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

        // Text in the middle for other states
        Text {
            id: displayText
            visible: main_column.state !== "Home"
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: digitalFont.name
            font.pointSize: 30
            color: "white" // Default color
            text: "Select an option" // Default text
        }
    }

    Rectangle{
        width: 600; height: 400
        anchors.left: 20

        ListModel{
            id: objectModell
            //TIME
            ListElement{file: "../img/Moon.png"
                        name: "Time"
            }
            //TIME
            ListElement{file: "../img/Moon.png"
                        name: "Time"
            }
            //TIME
            ListElement{file: "../img/Moon.png"
                        name: "Time"
            }
            //TIME
            ListElement{file: "../img/Moon.png"
                        name: "Time"
            }
            //TIME
            ListElement{file: "../img/Moon.png"
                        name: "Time"
            }
            //TIME
            ListElement{file: "../img/Moon.png"
                        name: "Time"
            }
        }

        Component{
            id:delegateItem

            Column{
                Image{
                    id:delegateImg
                    anchors.horizontalCenter: delegateText.horizontalCenter
                    source: file; width: 64; height: 64; smooth: true
                    fillMode: Image.PreserveAspectFit
                }
                Text{
                    id:delegateText
                    text: name; font.pixelSize: 24; font.family: digitalFont.name
                }
            }
        }

        GridView{
            //anchors.fill: parent
            width: 600; height: 400
            anchors.margins: 20
            model: objectModell
            delegate: delegateItem

            header: Rectangle{
                width: parent.width; height: 10
                color: "blue"
            }
            footer: Rectangle{
                width: parent.width
                color: "red"
            }
            highlight: Rectangle{
                width: parent.width
                color: "lightgray"
            }
        }

    }

    // Home GridView Layout
   /* GridView {
        id: homeGridView
        visible: main_column.state === "Home"
        width: parent.width
        height: parent.height - main_column.height - 20
        cellWidth: parent.width / 3
        cellHeight: (parent.height - main_column.height - 20) / 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        model: ListModel {
            ListElement { label: "Date" }
            ListElement { label: "Hostname\nIP" }
            ListElement { label: "Humidity" }
            ListElement { label: "Time" }
            ListElement { label: "Pressure" }
            ListElement { label: "Temperature" }
        }

        delegate: Item {
            width: homeGridView.cellWidth
            height: homeGridView.cellHeight

            Text {
                anchors.centerIn: parent
                text: model.label
                font.family: digitalFont.name
                font.pointSize: 24
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }*/

    // Image in the center of the screen
    Image {
        id: displayImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: main_column.state === "Light"
        width: 200  // Larger width
        height: 200 // Larger height
        source: sensorReader.sensorValue ? "../img/Moon.png" : "../img/Sun.png"
    }
}
