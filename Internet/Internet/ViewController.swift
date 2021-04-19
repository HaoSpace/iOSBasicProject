//
//  ViewController.swift
//  Internet
//
//  Created by kooapps on 4/18/21.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate, URLSessionDataDelegate, XMLParserDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var myData = (data: Data(), expectedLength: Int64())
    var tagName: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        sync()
//        sessionDataTask()
//        sessionDownloadTask()
//        sessionDownloadTaskWithSave()
//        sessionDataTestWithSave()
//        xmlRead()
//        jsonRead()
//        jsonReadCodable()
        
        progressView.progress = 0
        label.text = ""
    }
    
    func sync () {
        do {
            let url = URL(string: "https://apple.com")
            let html = try String(contentsOf: url!)
            print(html)
            
            // image
//            let urlImg = URL(string: "https://host_ip/a.jpg")
//            let data = try Data(contentsOf: urlImg!)
//            let image = UIImage(data: data)
            
        } catch {
            print(error)
        }
    }
    
    func sessionDataTask() {
        let url = URL(string: "https://www.apple.com")
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url!) {
            (data, response, error) in
            if error == nil, let data = data {
                let html = String(data: data, encoding: .utf8)
                print(html ?? "nononono")
            }
            else {
                print(error)
            }
        }
        
        dataTask.resume()
        
    }
    
    func sessionDownloadTask () {
        let url = URL(string: "https://apple.com")
        let session = URLSession(configuration: .default)
        
        let dnTask = session.downloadTask(with: url!) {
            (location, response, error) in
            if error == nil, let location = location {
                do {
                    let string = try String(contentsOf: location)
                    print(string)
                } catch {
                    print(error)
                }
            }
            else {
                print("no")
            }
        }
        
        dnTask.resume()
    }

    func sessionDownloadTaskWithSave () {
        let url = URL(string: "https://bre.is/YwABFww8")
        let session = URLSession(configuration: .background(withIdentifier: "abc"), delegate: self, delegateQueue: nil)
        let dnTask = session.downloadTask(with: url!)
        
        dnTask.resume()
    }
    
    func sessionDataTestWithSave () {
        let url = URL(string: "https://bre.is/YwABFww8")
//        let url = URL(string: "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json")
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let dataTask = session.dataTask(with: url!)
        
        dataTask.resume()
    }
    
    func urlPost (){
        let url = URL(string: "http://myweb")
        
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        
        request.httpBody = "qweqwe".data(using: .utf8)
        request.httpMethod = "POST"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) {
            (data, reponse, error) in
            if let data = data {
                let html = String(data: data, encoding: .utf8)
                print(html)
            }
        }
        
        dataTask.resume()
    }
    
    func xmlRead () {
        let url = Bundle.main.url(forResource: "test", withExtension: "xml")
        
        if let xml = XMLParser(contentsOf: url!) {
            xml.delegate = self
            xml.parse()
        }
    }
    
    func jsonRead () {
        let url = Bundle.main.url(forResource: "test", withExtension: "json")
        do {
            let data = try Data(contentsOf: url!)
            
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
            for p in jsonObj {
                print("naa: \(p["Name"]!)")
                print("add: \(p["Age"]!)")
                
                if let tels = p["Phone"] as? [String: String] {
                    print("off: \(tels["Office"]!)")
                    print("Hom: \(tels["Home"]!)")
                }
                
                print("---------------")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func jsonReadCodable () {
        let url = URL(string: "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json")
        let data = try! Data(contentsOf: url!)
        
        let raw = try! JSONDecoder().decode([AQI].self, from: data)
        raw.forEach {
            (p) in
            print(p)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let data = try? Data(contentsOf: location) {
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error == nil {
            print("complete")
            if myData.data.count > 0 {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: self.myData.data)
                   
//                    let raw = try! JSONDecoder().decode([AQI].self, from: self.myData.data)
//                    raw.forEach {
//                        (p) in
//                        print(p)
//                    }
                }
            }
          
        }
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("DidFinish")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        print("progress: \(progress)")
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        myData.expectedLength = response.expectedContentLength
        completionHandler(.allow)
        print("Receive1")
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        DispatchQueue.main.async {
            self.myData.data.append(data)
            let progress = Float(self.myData.data.count) / Float(self.myData.expectedLength)
            
            self.progressView.progress = progress
            self.label.text = String(Int(progress * 100)) + "%"
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        tagName = nil
        
        switch elementName {
        case "student":
            
            for key in attributeDict.keys {
                let value = attributeDict[key]
                print("\(key): \(value!)")
            }
        default:
            tagName = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard tagName != nil else {
            return
        }
        
        print("found: \(tagName!): \(string)")
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("end tag: \(elementName)")
        tagName = nil
    }
    
    
    
}

struct AQI: Codable {
//    enum CodingKey: String, CodingKey {
//        case description = "description"
//        case copyright = "copyright"
//        case title = "title"
//        case url = "url"
//        case apod_site = "apod_site"
//        case date = "date"
//        case media_type = "media_type"
//        case hdurl = "hdurl"
//    }
    
    var description: String
    var copyright: String
    var title: String
    var url: String
    var apod_site: String
    var date: String
    var media_type: String
    var hdurl: String
}

