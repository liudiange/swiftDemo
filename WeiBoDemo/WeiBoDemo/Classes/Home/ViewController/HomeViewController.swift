//
//  HomeViewController.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/1/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    var homeUIPresenter: HomeUIPresenter?
    var homeServicePresenter: HomeServicePresenter?
    
    private lazy var popAnimation: PopOverAnimation = PopOverAnimation { (isPresent) in
        self.homeUIPresenter?.setTitleButtonSelectAction(isPresent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPresenter()
    }
}
// MARK: 基本的ui
extension HomeViewController{
   
    private func setUpPresenter(){
        visterView.addToAnimation()
        if !isLogin {
            return
        }
        
        self.homeUIPresenter = HomeUIPresenter(self)
        self.homeUIPresenter?.uiDelegate = self
        self.homeUIPresenter?.setUpUI()
        
        self.homeServicePresenter = HomeServicePresenter(self)
        self.homeServicePresenter?.serviceDelegate = self
        
    }
}
// MARK: ui的delegate 实现
extension HomeViewController: UIPresenterDelegate{
    
    func clickTitle() {
        
        let popVc = PopOverController()
        
        popVc.modalPresentationStyle = .custom
        popVc.transitioningDelegate = popAnimation
        popAnimation.presentFrame = CGRect.init(x: 200, y: 84, width: 100, height: 180)
        self.present(popVc, animated: true, completion: nil)
    }
    
    func getNewData(_ sinceId: Int,_ maxId: Int){
        self.homeServicePresenter?.getNewData(sinceId, maxId)
    }
    
}
// MARK: 网络的相关的delegate
extension HomeViewController: HomeServicePresenterDelegate{
    
    func homeNewData(modelArray: [StatusViewModel]?){
        self.homeUIPresenter?.getHomeNewData(array: modelArray)
    }
}
