import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    // anchors.fill: parent

    BarChart {
        id: temperatureChart
        visible: !showTemperatureChart
        label: "Temperature"
        categories: sensorReader.chartHistoricTempsTimeCategories
        values: sensorReader.chartHistoricTempsData
        Component.onCompleted: {
            console.log("Temperature Screen loaded with values: ", values)
        }
    }

    DetailView {
        id: temperatureDetail
        visible: showTemperatureChart
        categories: sensorReader.historicTempsTimeCategories
        values: sensorReader.historicTemps

        Component.onCompleted: {
            console.log("Temperature Detail Screen loaded with values: ", values)
        }
    }
}
