import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    anchors.fill: parent

    Column {
        anchors.centerIn: parent

        Text {
            text: sensorReader.lightValue ? "It's sunny!" : "It's dark!"
            color: "white"
            font.pointSize: 30
            font.family: digitalFont.name
        }

        Image {
            source: sensorReader.lightValue ? "../img/Sun.png" : "../img/Moon.png"
            width: 200
            height: 200
            fillMode: Image.PreserveAspectFit
        }
    }

    Connections {
        target: sensorReader
        onLightValueChanged: {
            console.log("lightValue changed to: ", sensorReader.lightValue)
        }
    }
}
