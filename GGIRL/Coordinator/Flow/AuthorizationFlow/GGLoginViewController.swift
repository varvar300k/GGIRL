//
//  GGLoginViewController.swift
//  GGIRL
//
//  Created by VARVAR on 18.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import RxCocoa
import RxSwift
import Domain

class GGLoginViewController: NormalTraitsViewController, WKScriptMessageHandler, UIScrollViewDelegate, WKNavigationDelegate, WKUIDelegate {

    let disposeBag = DisposeBag()
    
    let userLoggedIn = PublishSubject<Void>()
    
    var toolbarWrapper: UIView!
    var webViewWrapper: UIView!
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        load()
    }
    
    func setupUI() {
        self.view.backgroundColor = .darkGrey
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        self.view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        webViewWrapper = UIView(frame: .zero)
        self.view.addSubview(webViewWrapper)
        webViewWrapper.edgesToSuperview()
        let contentController = WKUserContentController()
        contentController.add(self, name: "callbackHandler")
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        webView = WKWebView(frame: webViewWrapper.bounds, configuration: config)
        webViewWrapper.addSubview(webView)
        webView.edgesToSuperview()
        webView.scrollView.delegate = self
        webView.navigationDelegate = self
        webView.uiDelegate = self
    }
    
    func load() {
        activityIndicator.startAnimating()
        var request = URLRequest(url: URL(string: "https://goodgame.ru/login/")!)
        request.cachePolicy = .returnCacheDataElseLoad
        webView.load(request)
        webView.alpha = 0.5
    }

    func viewForZooming(in: UIScrollView) -> UIView? {
        return nil
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        do {
            guard let data = (message.body as? String)?.data(using: .utf8) else {return}
            let loginData = try! JSONDecoder().decode(Auth.self, from: data)
            
            let id = loginData.id
            let token = loginData.token != nil ? loginData.token : loginData.api_token
            
            UserController.shared.isUserAuthorized
                .asObservable()
                .debug()
                .subscribe(onNext: { [weak self] loginState in
                    if loginState {
                        print("Info: isUserAuthorized > true")
                        self?.userLoggedIn.onNext(())
                    }
                }).disposed(by: disposeBag)
            
            UserController.shared.login(userId: id!, token: token!)
            
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIView.animate(withDuration: 0.3) {
            webView.alpha = 1
        }
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if (navigationAction.targetFrame == nil) {
            let popup = WKWebView(frame: webViewWrapper.bounds, configuration: configuration)
            popup.uiDelegate = self
            popup.scrollView.delegate = self
            popup.navigationDelegate = self
            webViewWrapper.addSubview(popup)
            return popup
        }
        
        return nil
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if(navigationAction.request.url?.absoluteString.contains("oauth.vk.com/close.html"))! {
            webView.removeFromSuperview()
        }
        
        decisionHandler(.allow);
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                completionHandler()
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                completionHandler(true)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                completionHandler(false)
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.text = defaultText
            }
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                if let text = alertController.textFields?.first?.text {
                    completionHandler(text)
                } else {
                    completionHandler(defaultText)
                }
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                completionHandler(nil)
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func webView(_ webView: WKWebView, createWebViewWithConfiguration configuration: WKWebViewConfiguration!, forNavigationAction navigationAction: WKNavigationAction!, windowFeatures: WKWindowFeatures!) -> WKWebView! {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
}
