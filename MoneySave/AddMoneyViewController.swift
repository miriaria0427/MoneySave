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

class AddMoneyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    //セクション
    var sectionIndex:[String] = ["日付","金額","メモ"]
    //インデックスの配列
    let dateIndexPath: IndexPath = [0,0] //日付項目
    let moneyIndexPath: IndexPath = [1,0] //貯金額項目
    let memoIndexPath: IndexPath = [2,0] //メモ項目
    
    //セルの情報を保持しておく変数
    //let cellInfo: UITableViewCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        // データのないセルを表示しないようにする
        tableview.tableFooterView = UIView(frame: .zero)
        //セクションの高さ
        tableview.sectionHeaderHeight = 40;
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
            let f = DateFormatter()
            f.dateStyle = .long
            f.timeStyle = .none
            f.locale = Locale(identifier: "ja_JP")
            let now = Date()
            cell.textLabel!.text = (f.string(from: now))
        }else{
        cell.textLabel!.text = ""
        }
        return cell
    }
    
    @IBAction func AddMoney(_ sender: Any) {
    }
    
    //セクション名を返す
    func tableView(_ tableView:UITableView, titleForHeaderInSection section:Int) -> String?{
        print("セクション名\(sectionIndex[section])")
        return sectionIndex[section]
    }
    
    //セクションの個数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        print("数\(sectionIndex.count)")
        return sectionIndex.count
    }
    
    //各セルが選択された時の挙動
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath\(indexPath)")
        
        //SCLAlertViewのインスタンス作成
        let alert = SCLAlertView()
        
        switch indexPath {
        case dateIndexPath:
            //ピッカー設定
            let datePickerView:UIDatePicker = UIDatePicker()
            datePickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: datePickerView.bounds.size.height)
            datePickerView.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
            datePickerView.backgroundColor = UIColor.lightGray
            datePickerView.datePickerMode = UIDatePickerMode.date
            
            // 決定バーの生成
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
            let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
            toolbar.setItems([spacelItem, doneItem], animated: true)
            
            self.view.addSubview(datePickerView)
            self.view.addSubview(toolbar)
            
        case moneyIndexPath:
            let txt = alert.addTextField("入力")
            if let money = txt.text{
                print("お金の中身\(money)")//入力なし
            }else{
                return
            }
            alert.addButton("登録"){
                //登録ボタンタップ時の挙動（クロージャ）
                print("ボタンをタップしました")
                if let money = txt.text{
                    print("お金の中身\(money)")//入力値はここで拾えてる！
                }else{
                    return
                }
            }
            
            alert.showEdit("貯金", subTitle: "金額を入力して下さい")
            
        case memoIndexPath:
            SCLAlertView().showInfo("Important info", subTitle: "You are great")
        default: break
        }
        
    }
    
    // 決定ボタン押下
    @objc func done() {
        tableview.endEditing(true)
        
        // 日付のフォーマット
        //let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd"
        //textField.text = "\(formatter.string(from: Date()))"
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
