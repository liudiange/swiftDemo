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
        let jscode = "document.getElementById('userId').value='2586784401@qq.com';document.getElementById('passwd').value='QQldg@@032017';"
        webView.evaluateJavaScript(jscode) { (a, error) in
        }
    }
    // 存储token 并且用token去获取网络相关的数据
    fileprivate func loadToken(_ code: String) {
        NetWorkTools.shared.getAccessToken(code) { (accountModel) in
            guard let model = accountModel else{ return }
            self.loadUserInfo(accountModel: model)
        }
    }
    // 获取用户的信息并且存储
    fileprivate func loadUserInfo(accountModel: UserAccount){
        guard let accessToken = accountModel.access_token else { return }
        guard let uid = accountModel.uid else { return }
        
        NetWorkTools.shared.accessUserInfo(accessToken:accessToken, uid: uid) { [weak self] (serviceDic) in
            
            guard let dic = serviceDic else { return }
            
            accountModel.screen_name = dic["screen_name"] as? String
            accountModel.avatar_large = dic["avatar_large"] as? String
            
            // 存储方法
            NSKeyedArchiver.archiveRootObject(accountModel, toFile: UserAccountManager.shareInstance.accoutPath)
            UserAccountManager.shareInstance.accout = accountModel
            
            self?.dismiss(animated: true, completion: {
                UIApplication.shared.keyWindow?.rootViewController = WelcomeViewController()
            })
        }
    }
    
}
// MARK: - webview的代理
extension OAuthorController: WKUIDelegate,WKNavigationDelegate{
    // 开始加载的时候调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    // 加载完成的时候调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    // 当内容开始返回的时候调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    // 页面加载失败的时候调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
    // 拦截跳转的url
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        
        let urlStr = navigationAction.request.url?.absoluteString
        guard let needUrlStr = urlStr else {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }
        if !needUrlStr.contains("code=") {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }
        let tokenStr = (needUrlStr as NSString).components(separatedBy: "code=").last
        guard let token = tokenStr else {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }
        loadToken(token)
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
}
