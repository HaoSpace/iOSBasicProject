//
//  ViewController.swift
//  UIViewComponent
//
//  Created by kooapps on 4/13/21.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let fromList = ["台北松山", "桃園", "台中清泉剛", "高雄想鋼"]
    let toList = ["頏矮浦東", "香港赤臘角", "日本成田", "韓國仁川"]

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var activity1: UIActivityIndicatorView!
    @IBOutlet weak var progressBar1: UIProgressView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var textView1: UITextView!
    @IBOutlet weak var scrollView1: UIScrollView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //label 1
        label1.numberOfLines = 2
        let title = UIFont.preferredFont(forTextStyle: .title1)
        let footnote = UIFont.preferredFont(forTextStyle: .footnote)
        
        let style = NSMutableAttributedString(
            string: "Hello\n",
            attributes: [.font: title]
        )
        
        style.append(NSMutableAttributedString(string: "第二行", attributes: [.font: footnote, .foregroundColor: UIColor.blue]))
        
        label1.attributedText = style
        
        //button 1
        button1.isEnabled = true
        button1.isSelected = true
        button1.setTitle("中溫", for: .selected)
        
        progressBar1.progress = 0.9
        
        //imageView 1
        var images = [UIImage]()
        for i in 1...8 {
            let name = "\(i).png"
            images.append(UIImage(named: name)!)
        }
        imageView1.animationImages = images
        imageView1.animationDuration = 1
        imageView1.animationRepeatCount = 2
        imageView1.startAnimating()
        
        
        //TextView 1
        let url = Bundle.main.url(forResource: "File", withExtension: "rtf")
        if let url = url, let text = try?NSAttributedString(url: url, options: [.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil){
            textView1.attributedText = text
            textView1.isEditable = false
        }
        
        //Scrollview 1
        imageView2.image = UIImage(named: "5.png")
        let size = imageView2.image!.size
        scrollView1.contentSize = size
        
        scrollView1.minimumZoomScale = 1
        scrollView1.maximumZoomScale = 5
        scrollView1.zoomScale = 1
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        moveToCenter()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        moveToCenter()
        return imageView2
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        moveToCenter()
    }
    
    func moveToCenter() {
        let imageViewSize = imageView2.frame.size
        let scrollViewSize = scrollView1.frame.size
        var wPadding: CGFloat = 0
        var hPadding: CGFloat = 0
        
        if imageViewSize.width < scrollViewSize.width {
            wPadding = (scrollViewSize.width - imageViewSize.width) / 2
        }
        
        if imageViewSize.height < scrollViewSize.height {
            hPadding = (scrollViewSize.width - imageViewSize.height) / 2
        }
        
        scrollView1.contentInset = UIEdgeInsets(top: hPadding, left: wPadding, bottom: hPadding, right: wPadding)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return fromList.count
        }
        
        else if component == 1 {
            return toList.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return fromList[row]
        }
        
        else if component == 1 {
            return toList[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print("出發：\(fromList[row])")
        }
        
        else if component == 1 {
            print("到達：\(toList[row])")
        }
    }
   
    
    @IBAction func onClickSC(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        print(sender.titleForSegment(at: index)!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0, animations: {self.view.endEditing(true)})
        view.endEditing(true)
        
        var second = datePicker.countDownDuration
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            (timer) in guard second >= 0 else {
                timer.invalidate()
                return
            }
        
            print("剩餘\(second)秒")
            second -= 1
        }
    }
    
    @IBAction func onSlideValueChanged(_ sender: UISlider) {
        print(sender.value)
    }
    @IBAction func onSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn{
            print("on")
            activity1.startAnimating()
        }
        else {
            print("off")
            activity1.stopAnimating()
        }
    
    }
    @IBAction func onPageControllerValueChanged(_ sender: UIPageControl) {
        
        print(sender.currentPage)
    }
    @IBAction func onStepper(_ sender: UIStepper) {
        print(sender.value)
    }
}

