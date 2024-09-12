import CloudKit
import Foundation
import UserNotifications

func ScheduleNotification(for goal: Goal) {
    let content = UNMutableNotificationContent()
    content.title = "次のチートデイまでもう少し！"
    content.body = "\(goal.title) "
    content.sound = .default
    
    let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: goal.nextCheatDay)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request)
}
