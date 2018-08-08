//
//  Review.swift
//  MoneySave
//
//  Created by mayuka on 2018/08/06.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import Foundation
import RealmSwift

//貯金履歴管理用クラス
class Review: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    
    //日付
    @objc dynamic var date = Date()
    
    //貯金額
    @objc dynamic var saveMoney = 0
    
    //メモ
    @objc dynamic var memo = ""
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
}
