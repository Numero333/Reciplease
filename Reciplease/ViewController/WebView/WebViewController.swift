//
//  WebViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 24/03/2024.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    //MARK: - Property
    var webView: WKWebView!
    var model: WebViewModel!
    
    //MARK: - Override
    override func loadView() {
        webView = WKWebView()
        view = webView
        print(model.url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: model.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
