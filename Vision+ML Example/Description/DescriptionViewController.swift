//
//  DescriptionViewController.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/14/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit


class DescriptionViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides:[Slide] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        slides = createSlides()
                setupSlideScrollView(slides: slides)
                
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
    
    }
    func createSlides() -> [Slide] {//Slide.swiftで作ったimageView, labelTitle, labelDescにそれぞれ値をいれていく

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide1.imageView.image = UIImage(named: "cartred")
            slide1.labelTitle.text = "Shopping"
            slide1.labelDesc.text = "Take a picture of your shopping cart and keep your inventory."
            
            let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide2.imageView.image = UIImage(named: "cook")
            slide2.labelTitle.text = "Cooking"
            slide2.labelDesc.text = "Take a picture of ingredients before you cook."
            
            let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide3.imageView.image = UIImage(named: "camera")
            slide3.labelTitle.text = "Automated Management"
            slide3.labelDesc.text = "AI classification helps you categorize your inventory and track your expense."
            
            let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide4.imageView.image = UIImage(named: "calculate")
            slide4.labelTitle.text = "Recomendation for Recipe"
            slide4.labelDesc.text = "Look up the next menu and like your favorite recipe."
            
            
            let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide5.imageView.image = UIImage(named: "list")
            slide5.labelTitle.text = "A Shopping List"
            slide5.labelDesc.text = "No more checking inside your fridge before shopping."
            
            return [slide1, slide2, slide3, slide4, slide5]
        }
    
    func setupSlideScrollView(slides : [Slide]) {//scrollViewの形を整える
            scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
            scrollView.isPagingEnabled = true
            
            for i in 0 ..< slides.count {
                slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
                scrollView.addSubview(slides[i])
            }
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {//・・・を動くようにする
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)//・を定義、星にもできる
            pageControl.currentPage = Int(pageIndex)
            
            let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
            let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
            
            // vertical　綺麗にととのえる
            let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
            let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
            
            let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
            let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
            
            let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
                    
                    if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
                        
                        slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
                        slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
                        
                    } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
                        slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
                        slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
                        
                    } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
                        slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
                        slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
                        
                    } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
                        slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
                        slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
                    }
    }

}
//https://medium.com/@anitaa_1990/create-a-horizontal-paging-uiscrollview-with-uipagecontrol-swift-4-xcode-9-a3dddc845e92
//scrollview 参考

//https://icons8.com/illustrations/people/woman
//free illustration without backgrounds
