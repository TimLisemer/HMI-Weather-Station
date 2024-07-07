import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    anchors.fill: parent

    BarChart {
        label: "Temperature"
        categories: ["Jan", "Feb", "Mar", "Apr", "May"]
        values: [5, 10, 15, 20, 25] // Example data

        Component.onCompleted: {
            console.log("HumidityScreen loaded with values: ", values)
        }
    }
}
