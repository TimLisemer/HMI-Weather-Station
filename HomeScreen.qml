import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    anchors.fill: parent

    GridView {
        id: gridView
        anchors.fill: parent
        cellWidth: width / 3  // Drei Spalten
        cellHeight: 180  // Höhe der Zellen

        model: ListModel {
            ListElement { file: "../img/Moon.png"; name: "Time" }
            ListElement { file: "../img/Moon.png"; name: "Hostname / IP" }
            //ListElement { file: "../img/Moon.png"; name: "Hostname:" }
            //ListElement { file: "../img/Moon.png"; name: "IP:" }
            ListElement { file: "../img/Moon.png"; name: "Light" }
            ListElement { file: "../img/Moon.png"; name: "Humidity" }
            ListElement { file: "../img/Moon.png"; name: "Pressure" }
            ListElement { file: "../img/Moon.png"; name: "Temp" }
        }

        delegate: Component {
            Item {
                width: gridView.cellWidth
                height: gridView.cellHeight

                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    /*Image {
                        source: file
                        width: 64
                        height: 64
                        smooth: true
                        fillMode: Image.PreserveAspectFit
                    }*/
                    Text {
                        text: name
                        font.pixelSize: 35
                        font.family: digitalFont.name
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.Wrap
                    }

                    // Dynamisch verändernde Texte

                    Text {
                        text: name === "Hostname / IP" ? ""+ sensorReader.hostname + "\n" +sensorReader.ipAddress:""
                        font.pixelSize: 35
                        font.family: digitalFont.name
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        visible: name === "Hostname / IP"
                    }

                    /*Text {
                        text: name === "Hostname:" ? ""+ sensorReader.hostname : ""
                        font.pixelSize: 30
                        font.family: digitalFont.name
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        visible: name === "Hostname:"
                    }

                    Text {
                        text: name === "IP:" ? "" + sensorReader.ipAddress : ""
                        font.pixelSize: 30
                        font.family: digitalFont.name
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        visible: name === "IP:"
                    }*/

                    Text {
                        text: name === "Time" ? "" + sensorReader.berlinTime : ""
                        font.pixelSize: 35
                        font.family: digitalFont.name
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        visible: name === "Time"
                    }

                    Text {
                        text: name === "Humidity" ? "" + sensorReader.humidityDisplayText : ""
                        font.pixelSize: 35
                        font.family: digitalFont.name
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        visible: name === "Humidity"
                    }

                    Text {
                        text: name === "Pressure" ? "" + sensorReader.pressureDisplayText : ""
                        font.pixelSize: 35
                        font.family: digitalFont.name
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        visible: name === "Pressure"
                    }

                    Text {
                        text: name === "Temp" ? "" + sensorReader.tempDisplayText : ""
                        font.pixelSize: 35
                        font.family: digitalFont.name
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        visible: name === "Temp"
                    }
                }
            }
        }
    }
}



/*
  Text {
      text: "Hostname: " + sensorReader.hostname
      color: "white"
      font.pointSize: 24
  }

  Text {
      text: "IP Address: " + sensorReader.ipAddress
      color: "white"
      font.pointSize: 24
  }
*/
