//
//  ViewController.swift
//  AVCapture
//
//  Created by kooapps on 4/17/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate, AVCaptureFileOutputRecordingDelegate, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var forPreview: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    let captureSession = AVCaptureSession()
    let deviceInput = DeviceInput()
    
    let audioSession = AVAudioSession.sharedInstance()
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let tmpAudiourl = URL(fileURLWithPath: NSTemporaryDirectory() + "audio.ima4")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        settingPreviewLayer()
        captureSession.addInput(deviceInput.backWildAngleCamera!)
        captureSession.addInput(deviceInput.microphone!)
        
        //photo
//        session.sessionPreset = .photo
//        session.addOutput(AVCapturePhotoOutput())
        
        //quick time
//        captureSession.sessionPreset = .hd1280x720
//        captureSession.addOutput(AVCaptureMovieFileOutput())
        
        //QR Code
        let output = AVCaptureMetadataOutput()
        captureSession.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.global())
        
        captureSession.startRunning()
        
        cameraSetting()
        
        //audio
        print(tmpAudiourl.absoluteString)
        let audioSetting = [AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC)]
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: [])
            try audioSession.setActive(true)
            
            audioRecorder = try AVAudioRecorder(url: tmpAudiourl, settings: audioSetting)
        }
        catch {
            print(error)
        }
        
    }

    @IBAction func frontBackToggle(_ sender: UISwitch) {
        captureSession.beginConfiguration()
        
        captureSession.removeInput(captureSession.inputs.last!)
        
        if sender.isOn {
            captureSession.addInput(deviceInput.backWildAngleCamera!)
        }
        else {
            captureSession.addInput(deviceInput.frontWildAngleCamera!)
        }
        
        captureSession.commitConfiguration()
    }
    
    @IBAction func takeButton(_ sender: Any) {
        let setting = AVCapturePhotoSettings()
        setting.flashMode = .on
        
        let output = captureSession.outputs.first! as! AVCapturePhotoOutput
        output.capturePhoto(with: setting, delegate: self)
    }
    
    @IBAction func startRec(_ sender: Any) {
        let url = URL(fileURLWithPath: NSTemporaryDirectory() + "output.mov")
        let output = captureSession.outputs.first! as! AVCaptureMovieFileOutput
        
        output.startRecording(to: url, recordingDelegate: self)
    }
    
    @IBAction func stopRec(_ sender: Any) {
        let output = captureSession.outputs.first! as! AVCaptureMovieFileOutput
        
        output.stopRecording()
    }
    
    @IBAction func audioStart(_ sender: Any) {
        guard audioRecorder != nil else {
            return
        }
        
        if audioRecorder!.record() {
            print("start Audio Recording")
        }
    }
    
    @IBAction func audioStop(_ sender: Any) {
        guard audioRecorder != nil else {
            return
        }
        
        audioRecorder!.stop()
        print("stop Audio Recording")
    }
    
    @IBAction func audioPlay(_ sender: Any) {
        if audioPlayer == nil {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: tmpAudiourl)
            }
            catch
            {
                print(error)
                return
            }
        }
        
        if audioPlayer!.prepareToPlay(), audioPlayer!.play(){
            print("play")
        }
    }
    
    @IBAction func torchToggle(_ sender: UISwitch) {
        if let device = AVCaptureDevice.default(for: .video) {
            if device.hasTorch {
                do {
                    try device.lockForConfiguration()
                    if sender.isOn {
                        device.torchMode = .on
                    }
                    else {
                        device.torchMode = .off
                    }
                    
                    device.unlockForConfiguration()
                }
                catch {
                    print(error)
                }
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let image = UIImage(data: photo.fileDataRepresentation()!)
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(outputFileURL.path) {
            UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, self, #selector(RecordCompletion(_:error:contextInfo:)), nil)
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        for metaData in metadataObjects {
            if let data = metaData as? AVMetadataMachineReadableCodeObject {
                DispatchQueue.main.async {
                    self.codeLabel.text = data.stringValue
                    self.typeLabel.text = data.type.rawValue
                }
            }
        }
    }
    
    @objc func RecordCompletion (_ videoPath: String, error: Error?, contextInfo: Any?) {
        do {
            let fm = FileManager.default
            try fm.removeItem(atPath: videoPath)
        }
        catch {
            print(error)
        }
    }
    
    func settingPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer()
        previewLayer.frame = forPreview.bounds
        previewLayer.session = captureSession
        previewLayer.videoGravity = .resizeAspectFill
        forPreview.layer.addSublayer(previewLayer)
    }
    
    func cameraSetting() {
        let input = captureSession.inputs.last as! AVCaptureDeviceInput
        
        if input.device.deviceType == .builtInMicrophone {
            return
        }
        
        do {
            let camera = input.device
            try camera.lockForConfiguration()
            
            //測光
            if camera.isExposureModeSupported(.continuousAutoExposure) {
                camera.exposurePointOfInterest = CGPoint(x: 0.5, y: 0.5)
                camera.exposureMode = .continuousAutoExposure
            }
            
            // 對焦
//            if camera.isFocusModeSupported(.continuousAutoFocus) {
//                camera.focusPointOfInterest = CGPoint(x: 0.5, y: 0.5)
//                camera.focusMode = .continuousAutoFocus
//            }
            
            //對焦距離 不能與AutoFocus 同時
            camera.setFocusModeLocked(lensPosition: 0, completionHandler: nil)
            
            //快門, IOS
            camera.setExposureModeCustom(duration: CMTime(value: 1, timescale: 30), iso: 200, completionHandler: nil)
            
            camera.unlockForConfiguration()
            
        }
        catch {
            
        }
    }
}

