//
//  AddListViewController.swift
//  MoneySave
//
//  Created by mayuka on 2018/07/09.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit
import SCLAlertView
import RealmSwift
import ActionSheetPicker_3_0

class EditListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //セクション
    var sectionIndex:[String] = ["目標","金額","貯金履歴"]
    //インデックスの配列
    let goalIndexPath: IndexPath = [0,0] //目標内容
    let moneyIndexPath: IndexPath = [1,0] //目標金額
    //let memoIndexPath: IndexPath = [2,0] //貯金履歴
    
    //一覧画面から引き継いだ設定情報
    var money: Money!
    
    //表示項目
    var goalEdit : String?
    var moneyEdit : String?
    var reviewEdit:(Date?,String?,String?)
    
    //Realmインスタンスを作成する
    let realm = try!Realm()
    
    //ID昇順でソート（以降データが更新されるたびにリスト内は自動で更新される）
    //var taskArray = try!Realm().objects(Money.self).sorted(byKeyPath: "id",ascending: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // データのないセルを表示しないようにする
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //データの個数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return money.reviews.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath)
        //履歴に表示するための金額ラベルのインスタンスを取得
        let moneyEditLabel = cell.viewWithTag(1) as! UILabel
        //履歴のインスタンスを取得
        let review = Review()
        
        switch(indexPath.section){
        case 0:
            cell.textLabel?.text = money.goal
            goalEdit = cell.textLabel?.text
            moneyEditLabel.text = ""
        case 1:
            let editMoneyResult = changeFormat(setMoney:money.goalMoney)
            cell.textLabel?.text = editMoneyResult
            moneyEdit = cell.textLabel?.text
            moneyEditLabel.text = ""
        default:
            let f = DateFormatter()
            f.dateStyle = .long
            f.timeStyle = .none
            f.locale = Locale(identifier: "ja_JP")
            cell.textLabel?.text = (f.string(from: review.date))
            cell.detailTextLabel?.text = review.memo
            moneyEditLabel.text = review.saveMoney
        }
        return cell
    }
    
    //セクション名を返す
    func tableView(_ tableView:UITableView, titleForHeaderInSection section:Int) -> String?{
        return sectionIndex[section]
    }
    
    //セクションの個数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionIndex.count
    }
    
    //各セルが選択された時の挙動
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //SCLAlertViewのインスタンス作成
        let alert = SCLAlertView()
        //選択した表示中のセルを取得する
        let cell = tableView.cellForRow(at: indexPath)
        
        switch indexPath {
        //目標セルタップ
        case goalIndexPath:
            let txt = alert.addTextField("入力")
            alert.addButton("登録"){
                //登録ボタンタップ時の挙動（クロージャ）
                if let goal = txt.text{
                    cell?.textLabel?.text = goal
                    self.goalEdit = goal
                    
                }else{
                    return
                }
            }
            alert.showEdit("",subTitle: "目標を入力して下さい", closeButtonTitle: "キャンセル")
            
        //金額セルタップ
        case moneyIndexPath:
            //入力欄の作成
            let txt = alert.addTextField("入力")
            //キーボードタイプを数字のみに変更
            txt.keyboardType = UIKeyboardType.numberPad
            alert.addButton("登録"){
                //登録ボタンタップ時の挙動（クロージャ）
                if let money = txt.text{
                    cell?.textLabel?.text = ("¥\(money)")
                    self.moneyEdit = money
                }else{
                    return
                }
            }
            alert.showEdit("",subTitle: "金額を入力して下さい", closeButtonTitle: "キャンセル")
            
        default: break
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        print("登録ボタンが押された")
        let id = money.id
        let result = realm.objects(Money.self).filter("id == %@", id)
        let alert = SCLAlertView()
        //各入力欄が空白の場合アラートを表示する
        if(goalEdit == ""){
            //print("ゴールテキスト\(goalEdit)")
            alert.showWarning("", subTitle: "目標を入力して下さい", closeButtonTitle: "OK")
        }else if(moneyEdit == ""){
            //print("ゴールテキスト\(moneyEdit)")
            alert.showWarning("", subTitle: "金額を入力して下さい", closeButtonTitle: "OK")
        }else{
            //更新情報をRealmに保存する
            print("更新")
            try!realm.write{
                guard let goalEdit = goalEdit else { return }
                result[0].goal = goalEdit
                guard let moneyEdit = moneyEdit else { return }
                result[0].goalMoney = moneyEdit
            }
           //print("新しい目標\(goalEdit)")
           // print("新しい目標金額\(moneyEdit)")
            alert.showInfo("登録完了", subTitle: "")
        }
    }
    
    //金額項目を３桁に区切るメソッド
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
}
