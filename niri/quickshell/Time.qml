import Quickshell
import QtQuick

pragma Singleton

Singleton {
    readonly property string timeMinutes: {
        Qt.formatDateTime(clock.date, "hh:mm")
    }

    readonly property string timeSeconds: {
        Qt.formatDateTime(clock.date, "hh:mm:ss")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
