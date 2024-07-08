import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    anchors.fill: parent

    Column {
        anchors.centerIn: parent

        Text {
            text: Qt.formatDateTime(new Date(), "dddd, MMMM d, yyyy")
            color: "white"
            font.pointSize: 30
            font.family: digitalFont.name
        }

        Text {
            text: "Berlin Time: " + sensorReader.berlinTime
            color: "white"
            font.pointSize: 30
            font.family: digitalFont.name
        }

        Text {
            text: "UTC Time: " + sensorReader.utcTime
            color: "white"
            font.pointSize: 30
            font.family: digitalFont.name
        }

    }
}
