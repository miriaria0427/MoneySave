//
//  ListTableViewCell.swift
//  MoneySave
//
//  Created by mayuka on 2018/07/26.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Check_before: UIImageView! //選択チェック(未選択時)
    @IBOutlet weak var MokuhyoCellLabel: UILabel! //目標内容
    @IBOutlet weak var NowMoneyCellLabel: UILabel! //現在の貯金額
    @IBOutlet weak var SetMoneyCellLabel: UILabel! //目標額
    @IBOutlet weak var StatusCellLabel: UILabel! //達成・未達成
    @IBOutlet weak var Pig_NG: UIImageView! //豚(未達成時)
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
