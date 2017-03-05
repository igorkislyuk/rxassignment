//
// Created by Igor on 05/03/2017.
// Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

import Foundation

import RxSwift
import SwiftyJSON

protocol WallItemFetcher {
    func wallItems(for id: String, _ count: Int, _ offset: Int) -> Observable<[WallItem]>
}

class NetworkingManager {
}

extension NetworkingManager: WallItemFetcher {
    
    func wallItems(for id: String, _ count: Int = 20, _ offset: Int = 0) -> Observable<[WallItem]> {
        
        guard let url = urlForWallGetWith(id, count, offset) else {
            return Observable.just([])
        }
        
        return URLSession.shared.rx
            .json(url: url)
            .catchErrorJustReturn(Observable.just([]))
            .map {
                var wallItems = [WallItem]()
                
                JSON($0)["response"]
                    .forEach {
                        
                        let json = $0.1
                        let id = json["id"].intValue
                        let text = json["text"].stringValue
                        
                        guard id != 0 && !text.isEmpty else {
                            return
                        }
                        
                        let item = WallItem()
                        item.id = id
                        item.text = text
                        wallItems.append(item)
                }
                
                return wallItems
        }
        
    }
    
    private func urlForWallGetWith(_ id: String, _ count: Int, _ offset: Int) -> URL? {
        
        let string = "https://api.vk.com/method/"
            + "wall.get"
            + "?"
            + "owner_id=" + String(id) + "&"
            + "count=" + String(count) + "&"
            + "offset=" + String(offset)
        
        return URL(string: string)
    }
    
}
