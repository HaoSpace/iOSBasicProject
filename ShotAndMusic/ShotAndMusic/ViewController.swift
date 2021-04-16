//
//  ViewController.swift
//  ShotAndMusic
//
//  Created by kooapps on 4/16/21.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    var audio: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("有照相功能")
            
            if UIImagePickerController.isCameraDeviceAvailable(.front) {
                print("有前置")
            }
            
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                print("有後置")
            }
            
            if UIImagePickerController.isFlashAvailable(for: .front) {
                print("有前閃光")
            }
            
            if UIImagePickerController.isFlashAvailable(for: .rear) {
                print("有後閃光")
            }
        }
        
        
        //music
        NotificationCenter.default.addObserver(self, selector: #selector(audioInterrupted(_:)), name: AVAudioSession.interruptionNotification, object: nil)
        
        do {
            let url = Bundle.main.url(forResource: "1", withExtension: "m4a")
            try AVAudioSession.sharedInstance().setCategory(.playback)
            audio = try AVAudioPlayer(contentsOf: url!)
            if audio != nil {
                if audio!.prepareToPlay() {
                    print("play")
                    audio!.play()
                    
                    slider.minimumValue = 0
                    slider.maximumValue = Float(audio!.duration)
                    slider.value = 0
                    
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
                        (timer) in
                        self.ticker(timer: timer)
                    }
                }
            }
        } catch {
            print(error)
        }
        
    }

    @IBAction func onTakeShotClick(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("no camera")
            return
        }
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        show(imagePicker, sender: self)
    }
    
    @IBAction func onClickAlbum(_ sender: UIButton) {
        let imagePickerVC = UIImagePickerController()
        
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        
        imagePickerVC.modalPresentationStyle = .popover
        let popover = imagePickerVC.popoverPresentationController
        popover?.sourceView = sender
        
        popover?.sourceRect = view.bounds
        popover?.permittedArrowDirections = .any
        
        show(imagePickerVC, sender: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        
        if picker.sourceType == .camera {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
        imageView.image = image
       
        dismiss(animated: true, completion: nil)
    }
    
    func ticker(timer: Timer) {
        slider.value = Float(audio!.currentTime)
        if !audio!.isPlaying {
            print("over")
            timer.invalidate()
        }
    }
    
    @objc func audioInterrupted(_ notification: Notification) {
        guard audio != nil, let userInfo = notification.userInfo else {
            return
        }
        
        let type_tmp = userInfo[AVAudioSessionInterruptionTypeKey] as! NSNumber
        let type = AVAudioSession.InterruptionType(rawValue: type_tmp.uintValue)
        
        switch type {
        case .began:
            print("music stop")
        case .ended:
            print("music keep")
            
            let option_tmp = userInfo[AVAudioSessionInterruptionOptionKey] as! NSNumber
            let option = AVAudioSession.InterruptionOptions(rawValue: option_tmp.uintValue)
            
            if option == .shouldResume && audio!.prepareToPlay() {
                audio!.play()
            }
        default:
            break;
        }
      
    }
    @IBAction func OnSliderValueChanged(_ sender: UISlider) {
        audio?.currentTime = Double(sender.value)
    }
    
}

