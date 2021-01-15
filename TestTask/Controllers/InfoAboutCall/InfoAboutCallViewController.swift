//
//  InfoAboutCallViewController.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import UIKit

class InfoAboutCallViewController: UIViewController {

    enum AnimationStatus {
        case small
        case full
    }
    
    @IBOutlet weak var backgroundShadowView: UIView!
    @IBOutlet weak var smallBackgroundView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var viewUnderImage: UIView!
    @IBOutlet weak var callIconImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactAddressLabel: UILabel!
    @IBOutlet weak var callDurationLabel: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var businessLabel: UILabel!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessNumberLabel: UILabel!
    @IBOutlet weak var swipeIndicatorView: UIView!
    
    var animationStatus = AnimationStatus.full
    var calls: CallModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(showView))
            swipeDown.direction = .down
            self.backgroundView.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(hideView))
        swipeUp.direction = .up
            self.backgroundView.addGestureRecognizer(swipeUp)
    }
    
    func setupViews() {
        
        smallBackgroundView.backgroundColor = .white
        
        shadowView.layer.cornerRadius = 28
        shadowView.layer.shadowRadius = 16
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.05
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        backgroundShadowView.layer.cornerRadius = 16
        backgroundShadowView.layer.shadowRadius = 16
        backgroundShadowView.layer.shadowColor = UIColor.black.cgColor
        backgroundShadowView.layer.shadowOpacity = 0.05
        backgroundShadowView.layer.shadowOffset = CGSize(width: 0, height: 8)

        
        callIconImageView.image = UIImage(named: "call inbound missed")
        viewUnderImage.layer.masksToBounds = true
        viewUnderImage.layer.cornerRadius = 28
        
        contactNameLabel.text = "Name of contact"
        contactAddressLabel.text = "+1 917 123-4566"
        callDurationLabel.text = "08:24"
        businessLabel.text = "Business number"
        businessNameLabel.text = "Store"
        businessNumberLabel.text = "+1 888 123-5555"
    }
    
    @objc func hideView() {
        print("hide view")
        animateHideView()
        animationStatus = .small
    }
    
    @objc func showView() {
        print("show view")
        animateShowView()
        animationStatus = .full
    }
    
    func animateHideView() {
        switch animationStatus {
        case .full:
            UIView.animate(withDuration: 0.3) {
                self.backgroundView.frame = CGRect(x: self.backgroundView.frame.origin.x, y: -10, width: self.backgroundView.frame.width, height: self.backgroundView.frame.height)
                self.backgroundShadowView.frame = CGRect(x: self.backgroundShadowView.frame.origin.x, y: -10, width: self.backgroundShadowView.frame.width, height: self.backgroundShadowView.frame.height)
            }
        default:
            break
        }
    }
    
    func animateShowView() {
        
        switch animationStatus {
        case .small:
            UIView.animate(withDuration: 0.3) {
                self.backgroundView.frame = CGRect(x: self.backgroundView.frame.origin.x, y: 74, width: self.backgroundView.frame.width, height: self.backgroundView.frame.height)
                self.backgroundShadowView.frame = CGRect(x: self.backgroundShadowView.frame.origin.x, y: 74, width: self.backgroundShadowView.frame.width, height: self.backgroundShadowView.frame.height)
            }
        default:
            break
        }
    }
}
