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
    @IBOutlet weak var animationConstraint: NSLayoutConstraint!
    
    var viewModel: (InfoAboutCallViewModelInputs & InfoAboutCallViewModelOutputs)?
    
    var animationStatus = AnimationStatus.full
    var call: Request?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = InfoAboutCallViewModel()

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
        
        var duration = ""
        if let strongDuration = call?.duration {
            duration = viewModel?.changeDuration(duration: strongDuration) ?? ""
        }
        
        var telephone = ""
        var bussinessNumber = ""
        
        if let strongTelephone = call?.client.address,
           let strongBussinessNumber = call?.businessNumber.number {
            telephone = viewModel?.changeNumber(telephone: strongTelephone) ?? ""
            bussinessNumber = viewModel?.changeNumber(telephone: strongBussinessNumber) ?? ""
        }
        
        contactNameLabel.text = call?.client.name
        contactAddressLabel.text = telephone
        callDurationLabel.text = duration
        businessLabel.text = "Business number"
        businessNameLabel.text = call?.businessNumber.label
        businessNumberLabel.text = bussinessNumber
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
                
                self.animationConstraint.constant = 10
                self.view.layoutIfNeeded()
            }
        default:
            break
        }
    }
    
    func animateShowView() {
        
        switch animationStatus {
        case .small:
            UIView.animate(withDuration: 0.3) {
                
                self.animationConstraint.constant = 85
                self.view.layoutIfNeeded()
            }
        default:
            break
        }
    }
}
