import qs.Components
import qs
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire

WrapperMouseArea {
    id: volumeButton

    cursorShape: Qt.PointingHandCursor
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    implicitWidth: 55
    implicitHeight: 55

    child: speaker

    PwNodeLinkTracker {
        id: defaultTracker
        node: Pipewire.defaultAudioSink
    }

    WrapperRectangle {
        color: "#4f000000"
        id: speaker

        radius: 12
        margin: 6
    
        IconImage {
            source: Utils.volumeToIcon(defaultTracker.node)
            implicitSize: 32
        }
    }

    onClicked: ev => {
        if (ev.button == Qt.LeftButton) { volumeMixerWindow.visible = !volumeMixerWindow.visible }
        else if (ev.button == Qt.RightButton) { defaultTracker.node.audio.muted = !defaultTracker.node.audio.muted }
    }

    AudioMixer {
        id: volumeMixerWindow

        anchor {
            item: volumeButton
            rect {
                x: -width / 2 + 27.5
                y: 60
            }
        }
    }
}