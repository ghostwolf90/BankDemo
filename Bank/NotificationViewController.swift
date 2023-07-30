//
//  NotificationViewController.swift
//  Bank
//
//  Created by 仲立 on 2023/7/30.
//  Copyright © 2023 仲立. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class NotificationViewController: UIViewController {

    var notificationVM: NotificationVMInterface!
    private var disposeBag = DisposeBag()
    var notificationModelList: [NotificationModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        notificationVM = NotificationVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    func subscribeViewModel() {
        notificationVM.getNotificationListSubject
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (result) in
            print("result: \(result)" )
            self.notificationModelList = result.data
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        notificationVM.getNotificationList()
    }
    
    func initView() {
        tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }

}
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        cell.setDate(notification: notificationModelList[indexPath.row])
        return cell
    }

}
