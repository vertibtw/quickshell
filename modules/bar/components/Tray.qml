import qs
import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

Item {
    id: root
    property var parentwindow
    implicitHeight: trayrow.height
    implicitWidth: trayrow.width

    Row {
        id: trayrow
        spacing: 6
        anchors.centerIn: parent

        Repeater {
            model: SystemTray.items
            Rectangle {
                required property SystemTrayItem modelData
                implicitHeight: icon.height
                implicitWidth: height
                QsMenuAnchor {
                    id: menuanchor
                    menu: modelData.menu
                    anchor {
                        item: parent // took me way too long to figure out, qt docs are soo ass
                    }
                }

                color: "transparent"

                // stolen from https://github.com/josecriane/quickshell-config/blob/main/modules/bar/components/Tray.qml
                IconImage {
                    id: icon
                    height: parentwindow?.height * 0.75
                    width: height
                    source : {
                        let icon = modelData.icon;
                        if (icon.includes("?path=")) {
                            const [name, path] = icon.split("?path=");
                            return `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                        }
                        return icon;
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: (mouse) => {
                            if (mouse.button == Qt.LeftButton) {
                                modelData.activate()
                            } else {
                                menuanchor.open()
                            }
                        }
                    }
                }
            }
        }
    }
}