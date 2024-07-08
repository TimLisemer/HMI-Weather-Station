import QtQuick 2.12
import QtQuick.Controls 2.12
import QtCharts 2.12

Item {
    id: barChart
    property string label: ""
    property var values: []
    property var categories: []

    anchors.fill: parent

    ChartView {
        anchors.fill: parent
        antialiasing: true

        BarSeries {
            axisX: BarCategoryAxis {
                categories: barChart.categories
            }
            axisY: ValueAxis {
                min: 0
                max: values.length > 0 ? Math.max.apply(Math, values) * 1.1 : 100 // Dynamische Anpassung der Maximalwerte
            }

            BarSet {
                label: barChart.label
                values: barChart.values
            }
        }
    }
}
