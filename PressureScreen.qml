import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    BarChart {
        id: pressureChart
        visible: !showPressureChart
        label: "Pressure"
        categories: sensorReader.chartHistoricTimeCategories
        values: sensorReader.chartHistoricPressData
        Component.onCompleted: {
            console.log("Pressure Screen loaded with values: ", values)
        }
    }

    DetailView {
        id: pressureDetail
        visible: showPressureChart
        categories: sensorReader.chartHistoricTimeCategories
        values: sensorReader.chartHistoricPressData

        Component.onCompleted: {
            console.log("Pressure Detail Screen loaded with values: ", values)
        }
    }
}
