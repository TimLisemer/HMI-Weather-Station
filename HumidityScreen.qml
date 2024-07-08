import QtQuick 2.12
import QtQuick.Controls 2.12
import QtCharts 2.12

Item {
    // anchors.fill: parent

    BarChart {
        label: "Humidity"
        categories: ["Jan", "Feb", "Mar", "Apr", "May"]
        values: sensorReader.historicHums // Example data

        Component.onCompleted: {
            console.log("HumidityScreen loaded with values: ", values)
        }
    }

    /*Text {
        text: "" + sensorReader.humidityDisplayText
        font.pixelSize: 30
        font.family: digitalFont.name
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        visible: name === "Humidity"
    }*/


}
