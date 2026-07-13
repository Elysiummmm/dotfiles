import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs

PopupWindow {
    id: root
    color: 'transparent'

    implicitWidth: 500
    implicitHeight: 600

    PwNodeLinkTracker {
        id: linkTracker
        node: Pipewire.defaultAudioSink
    }

    ClippingWrapperRectangle {
        color: '#af000000'

        anchors.left: parent.left
        anchors.right: parent.right

        radius: 12
        margin: 8

        ColumnLayout {
            MixerEntry {
                node: Pipewire.defaultAudioSink
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            }

            Repeater {
                model: linkTracker.linkGroups

                MixerEntry {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    required property PwLinkGroup modelData
                    node: modelData.source
                }
            }
        }
    }
}