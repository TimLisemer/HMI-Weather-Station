import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    // anchors.fill: parent

    BarChart {
        label: "Temperature"
        categories: sensorReader.chartHistoricTimeCategories
        values: sensorReader.chartHistoricTempsData
        Component.onCompleted: {
            console.log("Temperature Screen loaded with values: ", sensorReader.chartHistoricTempsData)
        }
    }
}
