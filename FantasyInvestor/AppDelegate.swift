//
//  AppDelegate.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 14/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let configuration = ParseClientConfiguration {
            $0.applicationId = "TX0Ok21oV9wh3fIL2iCOTFNLh40lCd1xibx7ICaO"
            $0.clientKey = "8CoVK0IbGbmdwpAaNabtxspLKxoe6taNXA4DaT9o"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
//        saveInstallationObject()
        return true
    }
    
    func saveInstallationObject() {
        if let installation = PFInstallation.current() {
            installation.saveInBackground { (success: Bool, error: Error?) in
                if (success) {
                    print("You have successfully connected your app to Back4App!")
                } else {
                    if let myError = error {
                        print(myError.localizedDescription)
                    } else {
                        print("Unknown error")
                    }
                }
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

