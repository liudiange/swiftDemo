//
//  OAuthorController.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/4/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import WebKit

class OAuthorController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}
// MARK: 基本ui 使用
extension OAuthorController{
    private func setUpUI(){
        navigationItem.title = "授权页面"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(closeAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "填充", style: .plain, target: self, action: #selector(fillAction))
        
        loadPage()
    }
    private func loadPage(){
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        let url = URL.init(string: urlString)
        guard let needUrl = url else { return }
        
        let request = URLRequest.init(url: needUrl)
        webView.load(request)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
    }
}
// MARK: - 方法的响应
extension OAuthorController{
    @objc private func closeAction(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func fillAction(){
        
    }
}
// MARK: - webview的代理
extension OAuthorController: WKUIDelegate,WKNavigationDelegate{
    // 开始加载的时候调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // 加载完成的时候调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    // 当内容开始返回的时候调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    // 页面加载失败的时候调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
}
