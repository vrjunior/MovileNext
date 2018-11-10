//
//  AppDelegate.swift
//  NextNotification
//
//  Created by Valmir Junior on 10/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var center = UNUserNotificationCenter.current()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        center.delegate = self
        
        // here we can determine if we ask user the authorization or not
//        center.getNotificationSettings { (settings) in
//            switch settings.authorizationStatus {
//
//            case .authorized:
//                break
//            case .denied:
//                break
//            case .notDetermined:
//                break
//            default:
//                break
//            }
//        }
        
        let confirmAction = UNNotificationAction(identifier: "confirm", title: "Ok, vou ver 🤘🏻", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "cancel", title: "Cancelar", options: [])
        let category = UNNotificationCategory(identifier: "lembrete", actions: [confirmAction, cancelAction],
                       intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "",
                       options: [.allowInCarPlay, .customDismissAction])
        
        center.setNotificationCategories([category])
        
        center.requestAuthorization(options: [.alert, .badge, .sound, .carPlay]) { (success, error) in
            print(success)
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let id = response.notification.request.identifier
        //response.notification.request.content.userInfo["data"]
        
        switch response.actionIdentifier {
        case "confirm":
            break
        case "cancel":
            break
        case UNNotificationDefaultActionIdentifier:
            print("Tocou na notificação")
            
        case UNNotificationDismissActionIdentifier:
            print("Usuário dismissou a notificação")
            
        default:
            break
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // app open
        completionHandler([.alert, .badge, .sound])
    }
}
