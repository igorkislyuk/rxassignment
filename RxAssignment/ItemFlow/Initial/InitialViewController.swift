//
//  InitialViewController.swift
//  RxAssignment
//
//  Created by Igor on 05/03/2017.
//  Copyright © 2017 Igor Kislyuk. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxRealm

import RealmSwift

class InitialViewController: UIViewController, InitialView {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var openDetail: ((Int) -> ())?
    var fetcher: WallItemFetcher = NetworkingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performNetworkRequest()
        
        setupTableView()
        
        bindTable()
    }
    
    private func bindTable() {
        
        do {
            let realm = try Realm()
            
            Observable.collection(from: realm.objects(WallItem.self).sorted(byKeyPath: "id", ascending: false))
                .bindTo(tableView.rx.items(cellIdentifier: "Cell", cellType: WallCell.self) ) {
                    (_, item, cell) in
                    cell.itemTextLabel.text = item.text
                    cell.itemIDLabel.text = String(item.id)
                }.disposed(by: disposeBag)
            
            tableView.rx
                .modelSelected(WallItem.self)
                .asDriver()
                .drive(onNext: {
                    [weak self]
                    (item) in
                    self?.openDetail?(item.id)
                }).addDisposableTo(disposeBag)
            
            tableView.rx
                .itemSelected
                .asDriver()
                .drive(onNext: {
                    [weak self] (indexPath) in
                    self?.tableView.deselectRow(at: indexPath, animated: true)
                }).addDisposableTo(disposeBag)
            
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func performNetworkRequest() {
        
        //id = -49702876. From utils.resolveScreenName with `touchinstinct`
        
        fetcher.wallItems(for: "-49702876", 50, 0)
            .observeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "com.rxassignment.savingQueue"))
            .subscribe { [weak self] (event) in
                guard let items = event.element else {
                    return
                }
                
                self?.saveItems(items: items)
                
            }.addDisposableTo(disposeBag)
    }
    
    private func saveItems(items: [WallItem]) {
        do {
            
            let realm = try Realm()
            try realm.write {
                
                items.forEach({ (item) in
                    let contains = realm.objects(WallItem.self)
                        .contains(where: { (savedItem) -> Bool in
                            savedItem.id == item.id
                        })
                    
                    if !contains {
                        realm.add(item)
                    }
                    
                })
            }
            
        } catch {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
}

















