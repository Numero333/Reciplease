//
//  AppDelegate.swift
//  Reciplease
//
//  Created by François-Xavier on 18/03/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureTabBarAppearance()
        configureNavigationBarAppearance()
        return true
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
    
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(
            #colorLiteral(
                red: 0.2190445662,
                green: 0.1993097365,
                blue: 0.1953592896,
                alpha: 1
            )
        )
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    private func configureNavigationBarAppearance() {
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = UIColor(
            #colorLiteral(
                red: 0.2190445662,
                green: 0.1993097365,
                blue: 0.1953592896,
                alpha: 1
            )
        )
        UINavigationBar.appearance().standardAppearance = navigationAppearance
    }
}
