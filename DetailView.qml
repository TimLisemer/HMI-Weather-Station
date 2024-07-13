import QtQuick 2.12
import QtQuick.Controls 2.12
import QtCharts 2.12

Item {
    id: listView
    property string label: ""
    property var values: []
    property var categories: []

    anchors.fill: parent

    Column {
        anchors.fill: parent
        spacing: 5

        ListView {
            width: button_row.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            model: values
            delegate: Item {
                width: parent.width
                height: 65

                Rectangle {
                    width: parent.width
                    height: 60
                    color: "#f0f0f0"
                    border.color: "#cccccc"
                    radius: 10

                    Row {
                        width: parent.width
                        height: parent.height
                        anchors.centerIn: parent
                        spacing: 20

                        Item {
                            width: (parent.width - textItem.width) / 2
                            height: parent.height
                        }

                        Text {
                            id: textItem
                            text: "Time: " + categories[index] + "  -  Value: " + modelData
                            font.family: digitalFont.name
                            font.pointSize: 24
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Item {
                            width: (parent.width - textItem.width) / 2
                            height: parent.height
                        }
                    }
                }
            }

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOn
            }
        }
    }
}
