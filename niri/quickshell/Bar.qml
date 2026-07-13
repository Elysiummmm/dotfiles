import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.Tray
import qs.NowPlaying
import qs.Components
import qs.Notifications
import qs.Pipewire

Scope {
    Variants {
        model: [ Quickshell.screens[0] ]

        PanelWindow {
            id: topBar

            required property var modelData
            screen: modelData

            color: "#00000000"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 60

            RowLayout {
                layoutDirection: Qt.RightToLeft
                anchors.fill: parent
                anchors.rightMargin: 10
                spacing: 10

                SmallClockWidget { id: clock }
                NowPlayingWidget {
                    id: nowPlaying
                    anchors.right: clock.left
                }

                SystemTrayWidget {
                    id: tray
                    anchors.right: nowPlaying.left
                    anchors.rightMargin: 10
                }

                NotificationButton {
                    id: notifs
                    anchors.right: tray.left
                    anchors.rightMargin: 10
                }

                VolumeMixerWidget {
                    anchors.right: notifs.left
                    anchors.rightMargin: 10
                }
            }
        }
    }
}