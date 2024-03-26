//
//  WebViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 24/03/2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    var model = SearchRecipeModel()
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: model.selectedRecipe?.url ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
