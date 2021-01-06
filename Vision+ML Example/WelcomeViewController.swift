//
//  WelcomeViewController.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/9/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Lottie

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var animationview: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var charIndex = 0.0
        
        lottieAnimation()
        
        
        titleLabel.text = ""
        let titleText = "BANANA"
        for letter in titleText {
            print(0.05 * charIndex)
            print(letter)
            Timer.scheduledTimer(withTimeInterval: 0.3 * charIndex, repeats: false) {
                (timer) in self.titleLabel.text!.append(letter)
                
            }
            charIndex += 1
        }
        
       
}
            
    @IBAction func buttonTapped(sender:UIButton) {
        animateView(sender)
        
       
    }

    func lottieAnimation(){
        let animationview = AnimationView(name: "banana")
        animationview.frame = CGRect(x: 30, y: 0, width: 300, height: 390)
        animationview.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/8))//ちなみに2で割ると90度。4は45度回転
        animationview.contentMode = .scaleAspectFit
        view.addSubview(animationview)
        animationview.play()
    }

    func animateView(_ viewToAnimate:UIView) {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
            }) { (_) in
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
                    viewToAnimate.transform = .identity
                    
                }, completion: nil)
            }
    }
}


//https://zenn.dev/wecken/articles/97655ff212e3341bc20f

