//
//  UserDetailVC.swift
//  TwitterLoginDemo
//
//  Created by O2one Labs on 08/06/21.
//

import UIKit
import SDWebImage
import SwiftyJSON

class UserDetailVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userBanner: UIImageView!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var userScreenname: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var discription: UILabel!
    @IBOutlet weak var followersCountLbl: UILabel!
    @IBOutlet weak var followingCountLbl: UILabel!
    
    
    var userDetailModel: UserDetailModel?
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "UserProfileCell", bundle: nil), forCellReuseIdentifier: "UserProfileCell")
        self.setUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK:-- User Info --
    func setUserData(){
        
        userBanner.sd_setImage(with: URL(string: userDetailModel?.profile_banner_url ?? ""), placeholderImage: UIImage(named: "placeholder"))
        profileView.layer.cornerRadius = profileView.layer.frame.size.height/2
        profileView.layer.borderWidth = 1
        profileView.layer.borderColor = UIColor.black.cgColor
        profileImg.sd_setImage(with: URL(string: userDetailModel?.profile_image_url ?? "")!, placeholderImage: UIImage(named: "placeholder"))
        userScreenname.text = userDetailModel?.screen_name ?? ""
        email.text = userDetailModel?.email ?? ""
        discription.text = userDetailModel?.description ?? ""
        followersCountLbl.text = "\(userDetailModel?.following ?? 0)" + " Following"
        followingCountLbl.text = "\(userDetailModel?.followers_count ?? 0)" + " Followers"
        
        self.tableView.reloadData()
    }
    
}

//MARK: -- Table Delegates--
extension UserDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "UserProfileCell") as! UserProfileCell
        headerCell.followerCallBack = {
            print("follower")
//            self.fetchFollowers { json in
//                print(json)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
        }
        headerCell.followingCallBack = {
            print("following")
        }
        
        headerView.layer.frame.size.width = screenSize.width
        headerView.addSubview(headerCell)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

//MARK: -- API's Call--
extension UserDetailVC {
    func fetchFollowers(completionHandler: @escaping (JSON) -> Void) {
        
        let url = URL(string: "https://api.twitter.com/1.1/followers/list.json")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let followersData = try? JSON(data: data) {
                print(followersData)
                completionHandler(followersData)
            }
        })
        task.resume()
    }
}
