//
//  TweetCardTableViewCell.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 13/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//

import UIKit

class TweetCardTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetCardView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetCardView.shapeView()
        profileImageView.elevateShawdow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configureCell(tweet:Tweet){
        
        profileImageView.kf.indicatorType = .activity
        profileImageView.kf.setImage(with: tweet.user?.profile_image?.url, placeholder: #imageLiteral(resourceName: "twitter"))
        userNameLabel.text = tweet.user?.name ?? "Luke Skywalker"
        screenNameLabel.text = tweet.user?.screen_name ?? "Jedi"
        tweetLabel.text = tweet.text ?? "The last Jedi"

        
    }
}
