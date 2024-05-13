import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    color: "green"

    Text {
        visible: true
        anchors.centerIn: parent
        text: "Hello World"
        color: "red"
        font.pointSize: 36

    }

}

