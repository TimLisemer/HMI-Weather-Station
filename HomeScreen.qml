import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    anchors.fill: parent

    GridView {
        id: gridView
        anchors.fill: parent
        cellWidth: width / 3  // Drei Spalten
        cellHeight: 150  // Höhe der Zellen

        model: ListModel {
            ListElement { file: "../img/Moon.png"; name: "Time" }
            ListElement { file: "../img/Moon.png"; name: "Hostname \n IP" }
            ListElement { file: "../img/Moon.png"; name: "Light" }
            ListElement { file: "../img/Moon.png"; name: "Humidity" }
            ListElement { file: "../img/Moon.png"; name: "Pressure" }
            ListElement { file: "../img/Moon.png"; name: "Temperature" }
        }

        delegate: Component {
            Item {
                width: gridView.cellWidth
                height: gridView.cellHeight

                Column {
                    anchors.centerIn: parent
                    spacing: 10

                    Image {
                        source: file
                        width: 64
                        height: 64
                        smooth: true
                        fillMode: Image.PreserveAspectFit
                    }
                    Text {
                        text: name
                        font.pixelSize: 30
                        font.family: digitalFont.name
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.Wrap
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
