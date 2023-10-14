//
//  FeedTableCell.swift
//  Twitter-Demo
//
//  Created by MAC on 13/10/23.
//

import UIKit
import AVFoundation

class FeedTableCell: UITableViewCell {
    //MARK: - OUTLET
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewImgVerifiedContainer: UIView!
    @IBOutlet weak var imgVerified: UIImageView!
    @IBOutlet weak var lblHandlerName: UILabel!
    @IBOutlet weak var btnOption: UIButton!
    @IBOutlet weak var lblTextPost: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var stackCommentContainer: UIStackView!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var stackRetweetContainer: UIStackView!
    @IBOutlet weak var lblRetweetCount: UILabel!
    @IBOutlet weak var stackLikeContainer: UIStackView!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var stackViewContainer: UIStackView!
    @IBOutlet weak var lblViewCount: UILabel!
    @IBOutlet weak var stackUploadContainer: UIStackView!
    @IBOutlet weak var videoViewContainer: UIView!
    @IBOutlet weak var btnPlay: UIButton!
    
    //MARK: - PROPERTIES
    var optionBtnClicked: (() -> Void)?
    var commentClicked: (() -> Void)?
    var retweetClicked: (() -> Void)?
    var likeClicked: (() -> Void)?
    var viewsClicked: (() -> Void)?
    var player: AVPlayer?
    
    var feedData: HomeModel? {
        didSet{
            //profile image
            if let profileImage = UIImage(named: self.feedData?.profileImage ?? "") {
                self.imgProfile.image = profileImage
            }
            
            //name
            if let name = self.feedData?.name {
                self.lblName.text = name
            }
            
            //isVerified
            self.viewImgVerifiedContainer.isHidden = self.feedData?.isVerified ?? false
            
            //handlerName
            if let handlerName = self.feedData?.handlerName {
                self.lblHandlerName.text = "@\(handlerName)"
                
                if let postTime = self.feedData?.postTime {
                    self.lblHandlerName.text?.append(" - \(postTime)")
                }
            }
            
            //postText
            if let postText = self.feedData?.postText, postText != "" {
                self.lblTextPost.isHidden = false
                self.lblTextPost.text = postText
            } else {
                self.lblTextPost.isHidden = true
            }
            
            //postImage
            if let postImage = self.feedData?.postImage, postImage != "" {
                self.imgPost.isHidden = false
                self.imgPost.image = UIImage(named: postImage)
            } else {
                self.imgPost.isHidden = true
            }
            
            //postVideo
            if let postVideo = self.feedData?.postVideo, postVideo != "" {
                self.videoViewContainer.isHidden = false
                self.initializeVideoPlayer(videoName: postVideo)
            } else {
                self.videoViewContainer.isHidden = true
            }
            
            //commentCount
            if let commentCount = self.feedData?.commentCount, commentCount != "" {
                self.self.lblCommentCount.text = commentCount
            } else {
                self.lblCommentCount.text = "0"
            }
            
            //retweetCount
            if let retweetCount = self.feedData?.retweetCount, retweetCount != "" {
                self.lblRetweetCount.text = retweetCount
            } else {
                self.lblRetweetCount.text = "0"
            }
            
            //likesCount
            if let likesCount = self.feedData?.likesCount, likesCount != "" {
                self.lblLikeCount.text = likesCount
            } else {
                self.lblLikeCount.text = "0"
            }
            
            //viewsCount
            if let viewsCount = self.feedData?.viewsCount, viewsCount != "" {
                self.lblViewCount.text = viewsCount
            } else {
                self.lblViewCount.text = "0"
            }
        }
    }
    
    //MARK: - DeInit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        //add gesture
        addGesture()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - ADD GESTURE
    func addGesture() {
        //comment view
        let commentTap = UITapGestureRecognizer(target: self, action: #selector(handleCommentTap(_:)))
        stackCommentContainer.addGestureRecognizer(commentTap)
        
        //retweet view
        let retweetTap = UITapGestureRecognizer(target: self, action: #selector(handleRetweetTap(_:)))
        stackRetweetContainer.addGestureRecognizer(retweetTap)
        
        //Like view
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(handleLikeTap(_:)))
        stackLikeContainer.addGestureRecognizer(likeTap)
        
        //View view
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(handleViewTap(_:)))
        stackViewContainer.addGestureRecognizer(viewTap)
        
        //Video view container
        let videoViewContainerTap = UITapGestureRecognizer(target: self, action: #selector(handleVideoViewContainerTap(_:)))
        videoViewContainer.addGestureRecognizer(videoViewContainerTap)
    }
    
    //MARK: - GESTURE ACTIONS
    @objc func handleCommentTap(_ sender: UITapGestureRecognizer) {
        commentClicked?()
    }
    
    @objc func handleRetweetTap(_ sender: UITapGestureRecognizer) {
        retweetClicked?()
    }
    
    @objc func handleLikeTap(_ sender: UITapGestureRecognizer) {
        likeClicked?()
    }
    
    @objc func handleViewTap(_ sender: UITapGestureRecognizer) {
        viewsClicked?()
    }
    
    @objc func handleVideoViewContainerTap(_ sender: UITapGestureRecognizer) {
        if let player = player {
            if player.rate == 0 {
                self.playVideo()
            } else {
                self.pauseVideo()
            }
        }
        
    }
    
    // MARK: - BUTTON ACTIONS
    @IBAction func btnOptionClicked(_ sender: UIButton) {
        optionBtnClicked?()
    }
}

extension FeedTableCell {
    
    //MARK: - INITIALIZE VIDEO PLAYER
    func initializeVideoPlayer(videoName: String) {
        if let videoPath = Bundle.main.path(forResource: videoName, ofType: "mp4") {
            DispatchQueue.main.async {
                //initialise player from local asset
                let videoURL = URL(fileURLWithPath: videoPath)
                let playerItem = AVPlayerItem(url: videoURL)
                self.player = AVPlayer(playerItem: playerItem)
                
                //intialise and player layer
                let playerLayer = AVPlayerLayer(player:  self.player)
                playerLayer.frame =  self.videoViewContainer.bounds
                playerLayer.videoGravity = .resizeAspect
                self.videoViewContainer.layer.addSublayer(playerLayer)
                NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
                
                //keep play button front of all
                self.videoViewContainer.bringSubviewToFront(self.btnPlay)
            }
        }
    }
    
    //MARK: - PLAYER OBSERVER
    @objc func playerDidFinishPlaying(note: NSNotification) {
        showPlayButton()
    }
    
    //MARK: - HIDE SHOW PLAY BUTTON
    func showPlayButton() {
        btnPlay.isHidden = false
    }
    
    func hidePlayButton() {
        btnPlay.isHidden = true
    }
    
    //MARK: - PLAY VIDEO
    func playVideo() {
        //if player ends then start from beginning
        if  player?.currentItem?.currentTime() ==  player?.currentItem?.duration {
            player?.seek(to: CMTime.zero)
        }
        player?.play()
        hidePlayButton()
    }
    //MARK: - PAUSE VIDEO
    func pauseVideo() {
        player?.pause()
        showPlayButton()
    }
}
