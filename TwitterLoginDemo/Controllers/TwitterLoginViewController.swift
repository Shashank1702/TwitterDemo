//
//  ViewController.swift
//  TwitterLoginDemo
//
//  Created by O2one Labs on 08/06/21.
//

import UIKit
import TwitterKit
import Firebase
import FirebaseAuth
import SwiftyJSON

class TwitterLoginViewController: UIViewController {
    
    var firstName = ""
    var lastName = ""
    
    var provider = OAuthProvider(providerID: "twitter.com")
    
    var userDetailModel: UserDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        provider.customParameters = [
            "lang": "en"
        ]
        
    }
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        provider.getCredentialWith(nil) { credential, error in
          if error != nil {
            // Handle error.
          }
          if credential != nil {
            Auth.auth().signIn(with: credential!) { [self] authResult, error in
                if error != nil {
                    self.showAlertWith(message: "Authorization Failed!")
                }
                
                let json = self.createJson(profileData: authResult?.additionalUserInfo?.profile)
                print(json)
                userDetailModel = UserDetailModel(json: json)
                print(authResult as Any)
                print(userDetailModel ?? [String: Any].self)
                //print(authResult?.additionalUserInfo?.profile as? Any)
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let detailVC = sb.instantiateViewController(withIdentifier: "UserDetailVC") as! UserDetailVC
                detailVC.userDetailModel = self.userDetailModel
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
          }
        }
    }
    
    func createJson(profileData: [String: NSObject]?) -> [String:Any]{
        var dictJson = [String:Any]()
        dictJson["profile_image_url"] = profileData?["profile_image_url"] as? String ?? ""
        dictJson["email"] = profileData?["email"] as? String ?? ""
        dictJson["listed_count"] = profileData?["listed_count"] as? Int ?? ""
        dictJson["following"] = profileData?["following"] as? Int ?? ""
        dictJson["followers_count"] = profileData?["followers_count"] as? Int ?? ""
        dictJson["name"] = profileData?["name"] as? String ?? ""
        dictJson["created_at"] = profileData?["created_at"] as? String ?? ""
        dictJson["screen_name"] = profileData?["screen_name"] as? String ?? ""
        dictJson["id"] = profileData?["id"] as? String ?? ""
        dictJson["profile_banner_url"] = profileData?["profile_banner_url"] as? String ?? ""
        dictJson["description"] = profileData?["description"] as? String ?? ""
        dictJson["friends_count"] = profileData?["friends_count"] as? Int ?? ""
        dictJson["id_str"] = profileData?["id_str"] as? String ?? ""
        return dictJson
    }
    
    private func showAlertWith(message: String) {
        let alertController = UIAlertController(title: nil, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
    
}

