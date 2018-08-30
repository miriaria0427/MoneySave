//
//  Review.swift
//  MoneySave
//
//  Created by mayuka on 2018/08/06.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import RealmSwift

//貯金履歴管理用クラス
class Review: Object {
    
    //日付
    @objc dynamic var date = Date()
    
    //貯金額
    @objc dynamic var saveMoney = ""
    
    //メモ
    @objc dynamic var memo = ""
    
}
