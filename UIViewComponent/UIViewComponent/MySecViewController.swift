//
//  MySecViewController.swift
//  UIViewComponent
//
//  Created by kooapps on 4/14/21.
//

import UIKit
import WebKit

class MySecViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler {
    var webView: WKWebView!
    
    override func loadView() {
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = WKUserContentController()
        
        configuration.userContentController.add(self, name: "Test")
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        
        view = webView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "index", ofType: ".html")
        let url = URL(fileURLWithPath: path!)
        webView.loadFileURL(url, allowingReadAccessTo: url)
        // Do any additional setup after loading the view.
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let tmp = message.body as! String
        webView.evaluateJavaScript("setLableTitle('\(tmp)')", completionHandler: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        completionHandler()
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
