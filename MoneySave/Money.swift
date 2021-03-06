//
//  Money.swift
//  MoneySave
//
//  Created by mayuka on 2018/08/05.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import RealmSwift

//貯金額管理用クラス
class Money: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0

    //目標
    @objc dynamic var goal  = ""

    //目標貯金額
    @objc dynamic var goalMoney = "0"

    //現在の貯金額
    @objc dynamic var nowMoney = "0"

    //達成フラグ
    @objc dynamic var goalFlg = 0
    
    //選択フラグ
    @objc dynamic var selectedFlg = 0
    
    //貯金履歴(1対多リレーションシップの作成)
    let reviews = List<Review>()

    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
}




