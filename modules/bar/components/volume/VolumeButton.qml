import qs
import Quickshell
import QtQuick

Item {
    id: root
    property var volwidget

    implicitHeight: icon.height
    implicitWidth: icon.width

    Text {
        id: icon
        color: Colors.foreground
        text: {
            if (volwidget.vol === 0) {
                return "󰝟";
            } else if (volwidget.vol <= 30) {
                return "󰕿";
            } else if (volwidget.vol <= 60) {
                return "󰖀";
            } else if (volwidget.vol <= 100) {
                return "󰕾";
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                volwidget.visible = !volwidget.visible;
                States.bar_vol_popup_visible = !bar_vol_popup_visible;
            }
        }
    }
}
