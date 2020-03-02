//
//  HomeUIPresenter.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/14/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit


protocol UIPresenterDelegate: class{
 
    
    /// 点击了标题按钮
    func clickTitle()
    /// 获取最新的数据
    /// - Parameter sinceId: 开始的id
    /// - Parameter maxId: 最大的id
    func getNewData(_ sinceId: Int,_ maxId: Int)
    
}
let homeCellId = "homeCellId"
class HomeUIPresenter: NSObject {
    
    weak var homeVc: HomeViewController?
    
    weak var uiDelegate: UIPresenterDelegate?
    
    private lazy var titleButton = TitleButton()
    
    private lazy var dataArray = [StatusViewModel]()
    
    convenience init(_ vc: HomeViewController){
        self.init()
        self.homeVc = vc
    }
    private override init() { }
}
extension HomeUIPresenter{
    func setUpUI()  {
        
        self.homeVc?.navigationItem.title = "首页"
        
        self.homeVc?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIImageView.init(image: UIImage(named: "navigationbar_friendattention")))
        self.homeVc?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIImageView.init(image: UIImage(named: "navigationbar_pop")))
        
        titleButton.setTitle("shaoyeliu", for: .normal)
        titleButton.addTarget(self, action: #selector(titleClickAction(sender:)), for: .touchUpInside)
        self.homeVc?.navigationItem.titleView = titleButton
        
        self.homeVc?.tableView.delegate = self
        self.homeVc?.tableView.dataSource = self
        self.homeVc?.tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: homeCellId)
        self.homeVc?.tableView.estimatedRowHeight = 200
        
        
        self.homeVc?.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            // 获取最新的微博数据
            self?.uiDelegate?.getNewData(0, 0)
        })
        self.homeVc?.tableView.mj_header?.beginRefreshing()
    }
}
// MARK: 事件的响应
extension HomeUIPresenter{
    
    @objc private func titleClickAction(sender: TitleButton){
        self.uiDelegate?.clickTitle()
    }
    
    /// 返回了处理按钮的转改 界面进行相关的更改
    /// - Parameter isPresent: 是否弹出来了
    func setTitleButtonSelectAction(_ isPresent: Bool)  {
        titleButton.isSelected = isPresent
        
    }
    func getHomeNewData(array: [StatusViewModel]?)  {
        guard let viewModels = array else { return }
        self.dataArray = self.dataArray + viewModels
        self.homeVc?.tableView.mj_header?.endRefreshing()
        self.homeVc?.tableView.reloadData()
    }
}
// MARK:UITableViewDataSource 的部分实现
extension HomeUIPresenter: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = tableView.dequeueReusableCell(withIdentifier: homeCellId) as! HomeTableViewCell
        homeCell.selectionStyle = .none
        homeCell.model = self.dataArray[indexPath.row]
        return homeCell
    }
}
// MARK: UITableViewDelegate 的部分实现
extension HomeUIPresenter: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.dataArray[indexPath.row]
        return model.cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
