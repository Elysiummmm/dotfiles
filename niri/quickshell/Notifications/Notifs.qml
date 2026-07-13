import Quickshell
import Quickshell.Services.Notifications

pragma Singleton

Singleton {
    id: notificationService
    property list<var> list: []

    NotificationServer {
        id: server

        onNotification: notif => {
            notif.tracked = true
            notificationService.list = [notif, ...notificationService.list]
        }
    }

    function remove(notification) {
        let i = list.findIndex(e => e == notification);
        list.splice(i, 1)
    }

    function clearAll() {
        list.forEach(e => e.dismiss())
        list.length = 0
    }
}