//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Zainab Alibhai on 10/11/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    @IBAction func Onfavorite(_ sender: Any) {
        let favoriteIt = !favorited
        if (favoriteIt) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("favorite did not succed: \(Error)")
            })
        } else {
                TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                    self.setFavorite(false)
                }, failure: { (Error) in
                   print("Unfavorite did not succeed \(Error)")
                })
            }
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error is retweeting: \(Error)")
        }) 
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    
    func setFavorite(_ isFavorite:Bool){
        favorited = isFavorite
        if(favorited){
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
