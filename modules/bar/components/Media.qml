import qs
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Item {
    id: root

    property var player: Mpris.players.values.find(p => p.playbackState === MprisPlaybackState.Playing)
                         ?? Mpris.players.values[0]
                         ?? null

    implicitWidth: mediarow.width
    implicitHeight: mediarow.height

    anchors.verticalCenter: parent.verticalCenter

    Row {
        id: mediarow
        spacing: 6

        Text {
            text: root.player?.playbackState === MprisPlaybackState.Playing ? "󰏤" : "󰐊"
            color: Colors.light_blue
        }

        Rectangle {
            id: titleclip
            width: Math.min(150, titletext.implicitWidth)
            height: titletext.implicitHeight
            color: "transparent"
            clip: true

            Text {
                id: titletext
                text: root.player === null ? "No Media" : root.player?.trackTitle ?? "Unknown Title"
                color: Colors.foreground

                SequentialAnimation on x {
                    id: slidingthingy
                    running: titletext.implicitWidth > titleclip.width
                    loops: Animation.Infinite

                    PropertyAnimation {
                        from: 0
                        to: titleclip.width - titletext.implicitWidth - 10
                        duration: 4000
                        easing.type: Easing.Linear
                    }
                    
                    PauseAnimation { duration: 1000 }
                    
                    PropertyAnimation {
                        from: titleclip.width - titletext.implicitWidth - 10
                        to: 0
                        duration: 4000
                        easing.type: Easing.Linear
                    }
                    PauseAnimation { duration: 1000 }
                }
            }
        }

    }
    MouseArea {
        anchors.fill: mediarow
        onClicked: {
            root.player.togglePlaying()
        }
    }
}
