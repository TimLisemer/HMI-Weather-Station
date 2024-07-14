import QtQuick 2.12
import QtQuick.Controls 2.12
import QtCharts 2.12

Item {

    BarChart {
        id: humidityChart
        visible: !showHumidityChart
        label: "Humidity"
        categories: sensorReader.chartHistoricHumsTimeCategories
        values: sensorReader.chartHistoricHumsData

        Component.onCompleted: {
            console.log("Humidity Bar Chart loaded with values: ", values)
        }
    }

    DetailView {
        id: humidityDetail
        visible: showHumidityChart
        categories: sensorReader.historicHumsTimeCategories
        values: sensorReader.historicHums

        Component.onCompleted: {
            console.log("Humidity Detail Screen loaded with values: ", values)
        }
    }

}
