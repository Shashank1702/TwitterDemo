//
//  AppDelegate.swift
//  TwitterLoginDemo
//
//  Created by O2one Labs on 08/06/21.
//

import UIKit
import TwitterKit
import Firebase

let kTwitterConsumerKey = "DWgGzlDM0D05Vsrx65qCyasov"//"me45EazHmpRVGVn4ik1F8QLd9" // Provide your consumer key
let kTwitterConsumerSecretKey = "D2fRYDbfh9VvgJudMfrLy9zD2U5qgMJsCVMshyaLO25wncZF3z"//"LZ6HrQ3RbWUlJQOzmIROKRtAnmzEFmu7H8vW4SCd3CN9YcdoIz" // Provide your api key, as it is a sensitive information

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        TWTRTwitter.sharedInstance().start(withConsumerKey: kTwitterConsumerKey, consumerSecret: kTwitterConsumerSecretKey)
    
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        var valueTwitter: Bool = true
        valueTwitter = TWTRTwitter.sharedInstance().application(app, open: url, options: options)
        return valueTwitter
    }
    
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        if (extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard) {
            return false
        }
        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        var handle: Bool = true
        let options: [String: AnyObject] = [UIApplication.OpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject, UIApplication.OpenURLOptionsKey.annotation.rawValue: annotation as AnyObject]
        
        handle = TWTRTwitter.sharedInstance().application(application, open: url, options: options)
        return handle
        
    }


}

