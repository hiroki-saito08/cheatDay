import UserNotifications

func RequestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if granted {
            print("許可が与えられました")
        } else if let error = error {
            print("エラー: \(error.localizedDescription)")
        }
    }
}
