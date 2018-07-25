//
//  HomeViewController.swift
//  MoneySave
//
//  Created by mayuka on 2018/07/09.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var pig: UIImageView!
    @IBOutlet weak var Mokuhyolabel: UILabel!
    @IBOutlet weak var NowMoney: UILabel!
    @IBOutlet weak var SetMoney: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ->背景色を設定する
        self.view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 1.0, alpha:1.0)
        
        //ラベルに下線をつける
        let textlabel = NowMoney.text!
        let textAttributes: [NSAttributedStringKey : Any] = [
            //.font : UIFont.systemFont(ofSize: 24.0),
            //.foregroundColor : UIColor.green,
            //.strokeColor : UIColor.red,
            //.strokeWidth : -3.0,
            .underlineStyle :NSUnderlineStyle.styleSingle.rawValue
        ]
       
        let text = NSAttributedString(string: textlabel, attributes: textAttributes)
        NowMoney.attributedText = text
        
        //画像を設定する
        let pigImage = UIImage(named: "Pig_Pink.png")
        pig.image = pigImage
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}