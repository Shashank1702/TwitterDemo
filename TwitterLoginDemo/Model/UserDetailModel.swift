//
//  UserDetailModel.swift
//  TwitterLoginDemo
//
//  Created by O2one Labs on 08/06/21.
//

import Foundation

struct UserDetailModel {
    
    var profile_image_url: String?
    var email: String?
    var listed_count: Int?
    var following: Int?
    var followers_count: Int?
    var name: String?
    var created_at: String?
    var screen_name: String?
    var id: String?
    var profile_banner_url: String?
    var description: String?
    var friends_count: Int?
    var id_str: String?
    
    init(json: [String: Any]) {
        profile_image_url = json["profile_image_url"] as? String ?? ""
        email = json["email"] as? String ?? ""
        listed_count = json["listed_count"] as? Int ?? 0
        following = json["following"] as? Int ?? 0
        followers_count = json["followers_count"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        created_at = json["created_at"] as? String ?? ""
        screen_name = json["screen_name"] as? String ?? ""
        id = json["id"] as? String ?? ""
        id_str = json["id_str"] as? String ?? ""
        profile_banner_url = json["profile_banner_url"] as? String ?? ""
        description = json["description"] as? String ?? ""
        friends_count = json["friends_count"] as? Int ?? 0
    }
    
    
}
