//
//  DetailViewController.swift
//  RxAssignment
//
//  Created by Igor on 05/03/2017.
//  Copyright © 2017 Igor Kislyuk. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

class DetailViewController: UIViewController, DetailView {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    private var itemID: Int?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        observeButtonTap()
        
        updateUI()
    }
    
    func setupWith(detailID id: Int) {
        itemID = id
    }
    
    private func observeButtonTap() {
        addButton.rx.tap
            .asObservable()
            .subscribeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "com.rxassignment.savingQueue"))
            .subscribe(onNext: {
                [weak self]
                _ in
                self?.addOneMoreSign("!")
                self?.updateUI()
            }).addDisposableTo(disposeBag)
    }
    
    
    private func addOneMoreSign(_ sign: String) {
        guard let id = itemID else {
            return
        }
        
        do {
            let realm = try Realm()
            
            let wallItem = realm.objects(WallItem.self).first(where: { (item) -> Bool in
                item.id == id })
            
            realm.beginWrite()
            wallItem?.text += sign
            try realm.commitWrite()
            
        } catch {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    private func updateUI() {
        guard let id = itemID else {
            return
        }
        
        do {
            let realm = try Realm()
            
            if let wallItem = realm.objects(WallItem.self).first(where: { (item) -> Bool in
                item.id == id }) {
                
                textView.text = wallItem.text
            }
            
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}
