//
//  UserProfileCell.swift
//  TwitterLoginDemo
//
//  Created by O2one Labs on 08/06/21.
//

import UIKit

class UserProfileCell: UITableViewCell {

    @IBOutlet weak var followersBtn: UIButton!
    @IBOutlet weak var followingBtn: UIButton!
    
    var followerCallBack: (()->())?
    var followingCallBack: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func followerAction(_ sender: UIButton) {
        if sender.tag == 10 {
            followerCallBack?()
        }else{
            followingCallBack?()
        }
    }
    
    
}
