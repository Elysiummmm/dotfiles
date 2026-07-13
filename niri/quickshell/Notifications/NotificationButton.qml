import qs.Components
import qs
import Quickshell
import Quickshell.Widgets

WrapperMouseArea {
    id: notificationsButton

    cursorShape: Qt.PointingHandCursor
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    implicitWidth: 55
    implicitHeight: 55

    child: bell

    WrapperRectangle {
        color: "#4f000000"
        id: bell

        radius: 12
        margin: 6
    
        IconImage {
            source: {
                Notifs.list.length == 0
                    ? Utils.resolvedUrl("icons/bell-regular.png")
                    : Utils.resolvedUrl("icons/bell-solid.png")
            }
            implicitSize: 32
        }
    }

    onClicked: ev => {
        if (ev.button == Qt.LeftButton) {
            notificationsWindow.visible = !notificationsWindow.visible
            if (Notifs.list.length == 0) { notificationsWindow.visible = false }
        } else if (ev.button == Qt.RightButton && notificationsWindow.visible) {
            Notifs.clearAll()
            notificationsWindow.visible = false
        }
    }

    NotificationStack {
        id: notificationsWindow

        width: 500

        anchor {
            item: notificationsButton
            rect {
                x: -width / 2 + 27.5
                y: 60
            }
        }
    }
}