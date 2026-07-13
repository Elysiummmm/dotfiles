import Quickshell.Widgets
import QtQuick

WrapperMouseArea {
    default property var contents
    property bool highlightOverride: false
    property bool doesntHighlight: false
    property string defaultColor: "#ffffffff"

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    WrapperRectangle {
        radius: 12
        margin: 8

        color: {
            if (doesntHighlight) { return parent.defaultColor }

            let a = 0
            if (parent.containsMouse) { a += 20 }
            if (highlightOverride) { a += 20 }

            return `#${a == 0 ? "00" : a}ffffff`
        }

        children: contents
    }
}