import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    anchors.fill: parent

    BarChart {
        label: "Humidity"
        categories: ["Jan", "Feb", "Mar", "Apr", "May"]
        values: [30, 40, 45, 60, 70] // Example data

        Component.onCompleted: {
            console.log("HumidityScreen loaded with values: ", values)
        }
    }


}
