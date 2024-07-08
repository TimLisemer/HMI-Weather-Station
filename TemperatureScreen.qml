import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    // anchors.fill: parent

    BarChart {
        label: "Temperature"
        categories: ["Jan", "Feb", "Mar", "Apr", "May"]
        values: sensorReader.historicTemps

        Component.onCompleted: {
            console.log("HumidityScreen loaded with values: ", values)
        }
    }

    Text {
        text: "" + sensorReader.tempDisplayText
        font.pixelSize: 30
        font.family: digitalFont.name
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        visible: name === "Temp"
    }
}
