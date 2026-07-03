import qs 
import QtQuick
import Quickshell
import Quickshell.Services.UPower

Item {
    id: root

    implicitWidth: row.width
    implicitHeight: row.height

    property var battery: UPower.displayDevice

    Row {
        id: row
        spacing: 6

        Rectangle {
            radius: 5
            color: Colors.light_grey 
            width: percentage.width * 2
            height: percentage.height

            Rectangle {
                id: percentage_visual
                radius: parent.radius
                color: { 
                    if (Math.round(root.battery.percentage * 100) < 20) {
                        return Colors.red
                    } else {
                        return (root.battery.state == UPowerDeviceState.Charging) ? Colors.green : Colors.foreground
                    }
                }
                anchors.left: parent.left
                height: parent.height
                width: parent.width * root.battery.percentage;
            }

            Text {
                id: percentage
                text: (root.battery.state == UPowerDeviceState.Charging? "󱐋" : "") + Math.round(root.battery.percentage * 100)
                anchors.centerIn: parent
                color: Colors.background
            }
        }

    }
}