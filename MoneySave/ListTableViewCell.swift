//
//  ListTableViewCell.swift
//  MoneySave
//
//  Created by mayuka on 2018/07/26.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit
import RealmSwift

class ListTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var MokuhyoCellLabel: UILabel! //目標内容
    @IBOutlet weak var NowMoneyCellLabel: UILabel! //現在の貯金額
    @IBOutlet weak var SetMoneyCellLabel: UILabel! //目標額
    @IBOutlet weak var StatusCellLabel: UILabel! //達成・未達成
    @IBOutlet weak var Pig: UIImageView! //ぶたさんアイコン
    @IBOutlet weak var SelectedButton: UIButton!//選択ボタン
    @IBOutlet weak var EditButton: UIButton! //編集ボタン
    
    //カスタムセルにデータを反映させる
    func setPostData(money: Money){
        let nowMoneyResult = changeFormat(setMoney:money.nowMoney)
        let goalMoneyResult = changeFormat(setMoney:money.goalMoney)
        MokuhyoCellLabel?.text = money.goal
        NowMoneyCellLabel?.text = ("¥\(nowMoneyResult)")
        SetMoneyCellLabel?.text = ("¥\(goalMoneyResult)")
        
        if(money.goalFlg == 1){
            StatusCellLabel?.text = "達成"
            let pigImage = UIImage(named: "Pig_OK")
            Pig.image = pigImage

        }else{
            StatusCellLabel?.text = "未達成"
            let pigImage = UIImage(named: "Pig_NG")
            Pig.image = pigImage
        }
        
        if(money.selectedFlg == 1){
            let buttonImage = UIImage(named: "Check_after")
            self.SelectedButton.setImage(buttonImage, for: .normal)
        }else{
            let buttonImage = UIImage(named: "Check_before")
            self.SelectedButton.setImage(buttonImage, for: .normal)
        }
    }
    
    func changeFormat(setMoney:String) -> String{
        let setChangeMoney = setMoney
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        let unwrappedMoney = formatter.string(from: Int(setChangeMoney)! as NSNumber)
        if let formatedMoney = unwrappedMoney{
            return formatedMoney
        }else{
            return "0"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
