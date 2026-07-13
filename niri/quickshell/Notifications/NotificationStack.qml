import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs

PopupWindow {
    id: root
    color: 'transparent'

    implicitHeight: { Math.min(Notifs.list.length * 136 + 8, 900) }

    ClippingWrapperRectangle {
        color: '#af000000'
        anchors.fill: parent

        radius: 12
        margin: 8

        ScrollView {
            implicitHeight: 600

            ColumnLayout {
                spacing: 8

                Repeater {
                    model: Notifs.list

                    NotificationListEntry {
                        required property var modelData
                        notification: modelData
                    }
                }
            }
        }
    }
}