//
//  AppDelegate.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        _ = Connectivity.default.status
        Networking.initialize(with: Environment.networkConfig())
        nabbar()
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

    
    private func nabbar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .black
       
    }

}


enum Environment {
    static func networkConfig() -> NetworkingConfiguration {
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            assertionFailure("check for APP_API_BASE_URL, APP_CLIENT_ID and APP_CLIENT_SECRET in Info.plist and Target's Build Setting")
            return NetworkingConfiguration(baseURL: "", apiKey: "")
        }
        return NetworkingConfiguration(baseURL: baseURL, apiKey: apiKey) //"cf9221839ec238d0c609267eff5fb5f8"
    }
}
