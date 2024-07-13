import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    // anchors.fill: parent

    BarChart {
        label: "Pressure"
        categories: sensorReader.chartHistoricTimeCategories
        values: sensorReader.chartHistoricPressData
        Component.onCompleted: {
            console.log("HumidityScreen loaded with values: ", values)
        }
    }
}
