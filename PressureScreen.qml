import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    // anchors.fill: parent

    BarChart {
        label: "Pressure"
        categories: ["Jan", "Feb", "Mar", "Apr", "May"]
        values: [1010, 1020, 1030, 1040, 1050] // Example data

        Component.onCompleted: {
            console.log("HumidityScreen loaded with values: ", values)
        }
    }
}
