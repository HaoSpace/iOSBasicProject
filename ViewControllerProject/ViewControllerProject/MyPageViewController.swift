//
//  MyPageViewController.swift
//  ViewControllerProject
//
//  Created by kooapps on 4/15/21.
//

import UIKit
import AVKit

class MyPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var list = [UIViewController]()
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        list.append((storyboard?.instantiateViewController(withIdentifier: "vc1"))!)
        list.append((storyboard?.instantiateViewController(withIdentifier: "vc2"))!)
        list.append((storyboard?.instantiateViewController(withIdentifier: "vc3"))!)
        list.append((storyboard?.instantiateViewController(withIdentifier: "vc4"))!)
        
        setViewControllers([list[0]], direction: .forward, animated: true, completion: nil)
        // Do any additional setup after loading the view.
        dataSource = self
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = .cyan
        pageControl.currentPageIndicatorTintColor = .systemPink
        
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for v in view.subviews {
            if v is UIScrollView {
                v.frame = view.bounds
                break;
            }
        }
    }
    
    

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = list.index(of: viewController) {
            if index < list.count - 1 {
                
                if (index + 1 == 3) {
                    if let url = Bundle.main.url(forResource: "testMov", withExtension: "mp4") {
                        
                        let vc = list[3] as! AVPlayerViewController
                        vc.player = AVPlayer(url: url)
                        
                    }
                }
                
                
                return list[index + 1]
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = list.index(of: viewController) {
            if index > 0 {
                return list[index - 1]
            }
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
