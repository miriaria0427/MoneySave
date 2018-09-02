//
//  HomeViewController.swift
//  MoneySave
//
//  Created by mayuka on 2018/07/09.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit
import SCLAlertView
import RealmSwift

class HomeViewController: UIViewController {
        
    @IBOutlet weak var pig: UIImageView!
    @IBOutlet weak var Mokuhyolabel: UILabel!
    @IBOutlet weak var NowMoney: UILabel!
    @IBOutlet weak var SetMoney: UILabel!
    
    //Realmインスタンスを作成する
    let realm = try!Realm()
    
    //ID昇順でソート（以降データが更新されるたびにリスト内は自動で更新される）
    //var taskArray = try!Realm().objects(Money.self).sorted(byKeyPath: "id",ascending: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //URL確認する用（あとで消す）
        //let realm = try! Realm()
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        //背景色を設定する
        self.view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 1.0, alpha:1.0)
        
        //ラベルに下線をつける
        let textlabel = NowMoney.text!
        let textAttributes: [NSAttributedStringKey : Any] = [
            .underlineStyle :NSUnderlineStyle.styleSingle.rawValue
        ]
       
        let text = NSAttributedString(string: textlabel, attributes: textAttributes)
        NowMoney.attributedText = text
        
        //画像を設定する
        let pigImage = UIImage(named: "Pig_Pink.png")
        pig.image = pigImage
        //表示項目を設定する
        setView()
        // Do any additional setup after loading the view.
    }
    
    //貯金額入力画面から戻ってきた時に呼ばれるメソッド
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    //表示項目を設定するメソッド
    func setView(){
        let results = realm.objects(Money.self).filter("selectedFlg == 1")
        let nowMoneyResult = changeFormat(setMoney:results[0].nowMoney)
        let goalMoneyResult = changeFormat(setMoney:results[0].goalMoney)
        Mokuhyolabel.text = results[0].goal
        NowMoney.text =  ("¥\(nowMoneyResult)")
        SetMoney.text = ("¥\(goalMoneyResult)")
    }
    
    //金額項目を3桁に区切るメソッド
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
    
    //目標一覧画面から戻ってきた時に表示項目を再設定する
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView()
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
