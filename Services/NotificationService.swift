//
//  NotificationService.swift
//  F1 app
//
//  Created by Henrique Pacheco on 20/06/2025.
//

import Foundation
import NotificationCenter



protocol NotificationServiceProtocol {
    var isNotificationsEnabled : Bool { get }
    func verifyNotificationPermission()
    func scheduleNotification(data: Notification)
    func removeAllNotifications()
    
}


@Observable
class NotificationService {
    let notification : UNUserNotificationCenter
    var isNotificationsEnabled : Bool =  UserDefaults.standard.bool(forKey: "notificationsEnabled")
    
    init(notification: UNUserNotificationCenter) {
        self.notification = notification
        
    }
}


extension NotificationService: NotificationServiceProtocol {
    func verifyNotificationPermission() {
        notification.getNotificationSettings { settings in
                    switch settings.authorizationStatus {
                    case .authorized, .provisional, .ephemeral:
                        self.setNotificationsEnabled(true)

                    case .denied:
                        print("Permission denied")
                        self.setNotificationsEnabled(false)

                    case .notDetermined:
                        self.notification.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                            if granted {
                                self.setNotificationsEnabled(true)
                            } else {
                                print("User denied permission")
                                self.setNotificationsEnabled(false)
                            }
                        }

                    @unknown default:
                        print("Unknown authorization status")
                        self.setNotificationsEnabled(false)
                    }
            }
    }
    
    private func setNotificationsEnabled(_ enabled: Bool) {
            DispatchQueue.main.async {
                self.isNotificationsEnabled  = enabled
                print(self.isNotificationsEnabled)
                UserDefaults.standard.set(enabled, forKey: "notificationsEnabled")
            }
        }
    
    func removeAllNotifications()  {
        notification.removeAllPendingNotificationRequests()
        self.setNotificationsEnabled(false)
        
    }
    
    func scheduleNotification(data: Notification) {
        let identifier = "event_\(data.id)"
        notification.getPendingNotificationRequests { requests in
            let alreadyExists = requests.contains { $0.identifier == identifier }
            if alreadyExists {
                return
            }

            if self.isNotificationsEnabled {
                let content = UNMutableNotificationContent()
                content.title = data.title
                content.subtitle = data.subtitle
                content.sound = UNNotificationSound.default
                print(data.date ?? "")
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: data.date ?? Date())
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                self.notification.add(request)
            }
        }
    }
    
}
