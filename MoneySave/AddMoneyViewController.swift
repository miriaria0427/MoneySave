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

class AddMoneyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    //セクション
    var sectionIndex:[String] = ["日付","金額","メモ"]
    //インデックスの配列
    let dateIndexPath: IndexPath = [0,0] //日付項目
    let moneyIndexPath: IndexPath = [1,0] //貯金額項目
    let memoIndexPath: IndexPath = [2,0] //メモ項目
    
    //Realmインスタンスを作成する
    let realm = try!Realm()
    
    //入力した貯金額を保存
    var addInputMoney : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        // データのないセルを表示しないようにする
        tableview.tableFooterView = UIView(frame: .zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //データの個数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddMoneyCell", for: indexPath)
        //１番目のセクションには本日日付を初期表示する
        if(indexPath == dateIndexPath){
            //XX年X月X日の形に変換
            let f = DateFormatter()
            f.dateStyle = .long
            f.timeStyle = .none
            f.locale = Locale(identifier: "ja_JP")
            let now = Date()
            cell.textLabel?.text = (f.string(from: now))
        }else{
            cell.textLabel?.text = ""
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
    
    //各セルが選択された時の挙動（書き方あとで見直したい..)
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //SCLAlertViewのインスタンス作成
        let alert = SCLAlertView()
        //選択した表示中のセルを取得する
        let cell = tableView.cellForRow(at: indexPath)
        
        switch indexPath {
        //日付セルタップ
        case dateIndexPath:
            let timePicker = ActionSheetDatePicker(title: "", datePickerMode: UIDatePickerMode.date, selectedDate: Date(), doneBlock: {
                picker, value, index in
                //Done押下時は日付情報を反映する
                //XX年X月X日の形に変換
                let f = DateFormatter()
                f.dateStyle = .long
                f.timeStyle = .none
                f.locale = Locale(identifier: "ja_JP")
                cell?.textLabel?.text = f.string(for: value)
                return
            }, cancel: {ActionStringCancelBlock in
                print("cancel")
                return }, origin: self.view)
            timePicker?.locale = Calendar.current.locale
            timePicker?.show()
            
        //金額セルタップ
        case moneyIndexPath:
            //入力欄の作成
            let txt = alert.addTextField("入力")
            //キーボードタイプを数字のみに変更
            txt.keyboardType = UIKeyboardType.numberPad
            alert.addButton("登録"){
                //登録ボタンタップ時の挙動（クロージャ）
                if let money = txt.text{
                    //入力値が空白の場合何もしない
                    if(txt.text == ""){
                        return
                    }else{
                        //計算用に入力値を退避
                        self.addInputMoney = money
                        //3桁に区切ってから文字列に変換
                        let formatter = NumberFormatter()
                        formatter.numberStyle = NumberFormatter.Style.decimal
                        formatter.groupingSeparator = ","
                        formatter.groupingSize = 3
                        //変換した結果のアンラップ処理
                        let unwrappedMoney = formatter.string(from: Int(money)! as NSNumber)
                        guard let money = unwrappedMoney else { return }
                        //入力値を反映
                        cell?.textLabel?.text = ("¥\(money)")
                    }
                }else{
                    return
                }
            }
            alert.showEdit("",subTitle: "金額を入力して下さい", closeButtonTitle: "キャンセル")
            
        //メモセルタップ
        case memoIndexPath:
            let txt = alert.addTextField("入力")
            alert.addButton("登録"){
                //登録ボタンタップ時の挙動（クロージャ）
                if let memo = txt.text{
                    //入力値が空白の場合何もしない
                    if(txt.text == ""){
                        return
                    }else{
                        print("メモの中身\(memo)")
                        cell?.textLabel?.text = memo
                    }
                }else{
                    return
                }
            }
            alert.showEdit("",subTitle: "メモを入力して下さい", closeButtonTitle: "キャンセル")
        default: break
        }
    }
    
    //登録ボタン押下時の処理
    @IBAction func AddButton(_ sender: Any) {
        //金額セルの情報を取得
        let moneyCell = tableview.cellForRow(at: moneyIndexPath)
        //アラートビューのインスタンス取得
        let alert = SCLAlertView()
        //現在選択中のデータを抽出
        let result = realm.objects(Money.self).filter("selectedFlg == 1")
        //let nowMoney = result[0].nowMoney
        //金額入力欄が空白の場合アラートを表示する
        if(moneyCell?.textLabel?.text == ""){
            alert.showWarning("", subTitle: "金額を入力して下さい", closeButtonTitle: "OK")
        }else{
            //計算用にInt変換する
            //現在の貯金額
            let addNowMoney : Int = Int(result[0].nowMoney) ?? 0
            print("現在の貯金額\(addNowMoney)")
            //let addInputMoney : String = moneyCell?.textLabel?.text ?? ""
            //print("入力した貯金額\(addInputMoney)")
            //追加した金額(入力時点でnilでないことを確認しているので強制アンラップ）
            let addMoney : Int = Int(addInputMoney!) ?? 0
            //print("追加した金額\(addMoney)")
            let newNowMoney = addNowMoney + addMoney
            
            //登録情報をrealmに保存する
            try! realm.write {
                result[0].nowMoney = String(newNowMoney)
            }
            //登録完了のポップアップを表示
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
     */
    
}
