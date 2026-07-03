import qs
import qs.modules.bar
import Quickshell
import QtQuick
import QtQuick.Controls

Item {
    id: root

    property string format: "hh:mm"

    implicitHeight: r.height
    implicitWidth: r.width


    Row {
        id: r
        spacing: 8
        // Text {
        //     id: icon
        //     color: Colors.yellow
        //     text: "󱑆"
        // }

        Text {
            id: clock
            color: Colors.foreground
            font.pixelSize: 12 // TODO: make this depend on bar height/width or whatever

            Timer {
                interval: 1000
                running: true
                repeat: true

                onTriggered: {
                    clock.text = Qt.formatDateTime(new Date(), root.format);
                }
            }

            Component.onCompleted: {
                clock.text = Qt.formatDateTime(new Date(), root.format)
            }
        }
    }
}