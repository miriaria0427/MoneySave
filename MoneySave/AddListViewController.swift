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

class AddListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //インデックスの配列
    let goalIndexPath: IndexPath = [0,0] //日付項目
    let moneyIndexPath: IndexPath = [1,0] //貯金額項目
    
    //目標金額保存用変数
    var SaveGoalMoney : String?
    
    //Realmインスタンスの作成
    let realm = try!Realm()
    //ID昇順でソート
    var taskArray = try!Realm().objects(Money.self).sorted(byKeyPath: "id",ascending: true)
    
    //セクション
    var sectionIndex:[String] = ["目標","金額"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // データのないセルを表示しないようにする
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //データの個数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath)
        // 値を設定する.
        cell.textLabel!.text = ""
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
        case goalIndexPath:
            let txt1 = alert.addTextField("入力")
            alert.addButton("登録"){
                //登録ボタンタップ時の挙動（クロージャ）
                if let goal = txt1.text{
                    cell?.textLabel?.text = goal
                }else{
                    return
                }
            }
            alert.showEdit("",subTitle: "目標を入力して下さい", closeButtonTitle: "キャンセル")
            
        case moneyIndexPath:
            //入力欄の作成
            let txt2 = alert.addTextField("入力")
            //キーボードタイプを数字のみに変更
            txt2.keyboardType = UIKeyboardType.numberPad
            alert.addButton("登録"){
                //登録ボタンタップ時の挙動（クロージャ）
                if let money = txt2.text{
                    //Realmへの保存用に目標金額を保存用変数に退避
                    self.SaveGoalMoney = money
                    //3桁に区切ってから文字列に変換
                    let formatter = NumberFormatter()
                    formatter.numberStyle = NumberFormatter.Style.decimal
                    formatter.groupingSeparator = ","
                    formatter.groupingSize = 3
                    //変換した結果のアンラップ処理
                    let unwrappedMoney = formatter.string(from: Float(money)! as NSNumber)
                    guard let goalMoney = unwrappedMoney else { return }
                    //入力値を反映
                    cell?.textLabel?.text = ("¥\(goalMoney)")
                }else{
                    return
                }
            }
            alert.showEdit("",subTitle: "金額を入力して下さい", closeButtonTitle: "キャンセル")
            
        default: break
        }
    }
    
    //登録ボタン押下時の挙動
    @IBAction func AddList(_ sender: Any) {
        //表示中のセルを取得する
        let goalCell = tableView.cellForRow(at: goalIndexPath)
        let moneyCell = tableView.cellForRow(at: moneyIndexPath)
        
        let alert = SCLAlertView()
        //各入力欄が空白の場合アラートを表示する
        if(goalCell?.textLabel?.text == ""){
            alert.showWarning("", subTitle: "目標を入力して下さい", closeButtonTitle: "OK")
        }else if(moneyCell?.textLabel?.text == ""){
            alert.showWarning("", subTitle: "金額を入力して下さい", closeButtonTitle: "OK")
        }else{
            let money = Money()
            let allMoneys = realm.objects(Money.self)
            //登録情報をRealmに保存する
            try! realm.write {
                    print("goal:\((goalCell?.textLabel?.text)!)")
                    if allMoneys.count != 0 {
                    money.id = allMoneys.max(ofProperty:"id")! + 1
                    }
                    money.goal = (goalCell?.textLabel?.text)!
                    money.goalMoney = SaveGoalMoney!
                    money.goalFlg = 0
                //初回登録時は選択フラグに1を設定
                if(taskArray.count == 0){
                    money.selectedFlg = 1
                }
                    realm.add(money, update: true)
            }
            //登録成功のポップアップを表示して画面を閉じる
            alert.showInfo("登録完了", subTitle: "")
        }
    }
    
    /*
     // MARK: - Navigation
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
   alert.showWarning("", subTitle: "目標を入力して下さい", closeButtonTitle: "OK")  */
    
}
