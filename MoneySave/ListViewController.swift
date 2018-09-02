//
//  ListViewController.swift
//  MoneySave
//
//  Created by mayuka on 2018/07/09.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Realmインスタンスを作成する
    let realm = try!Realm()
    
    //ID昇順でソート
    var taskArray = try!Realm().objects(Money.self).sorted(byKeyPath: "id",ascending: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Identiferを設定
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
    }
    
    @IBAction func returnToList(_ segue: UIStoryboardSegue) {
    }
    
    //データの個数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.setPostData(money: taskArray[indexPath.row])
        
        // セル内のボタンのアクションをソースコードで設定する
        cell.SelectedButton.addTarget(self, action:#selector(handleSelectedButton(_:forEvent:)), for: .touchUpInside)
        
        return cell
    }
    
    
    //セルをタップした時にタスク編集画面に遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルがタップされました")
        performSegue(withIdentifier: "cellSegue",sender: self.tableView)
    }
    
    //タスク編集画面に遷移する時に現在の設定情報を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //タグがcellSegueの時に値を引き継ぐ
        if segue.identifier! == "cellSegue" {
            let EditListViewController : EditListViewController = segue.destination as! EditListViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            EditListViewController.money = taskArray[indexPath!.row]
        }else{
            //addSegueのときは何もしない
            return
        }
    }
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // チェックボタンがタップされた時に呼ばれるメソッド
    @objc func handleSelectedButton(_ sender: UIButton, forEvent event: UIEvent) {
        print("DEBUG_PRINT: セレクトボタンがタップされました。")
        
        // タップされたセルのインデックスを求める
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        print("point\(point)")
        let indexPath = tableView.indexPathForRow(at: point)
        print("indexPath\(indexPath!)")
        let taskData = taskArray[indexPath!.row]
        print("taskData\(taskData)")
        
        //選択フラグの状態に応じてチェックボタンを制御する
        let results = realm.objects(Money.self).filter("selectedFlg == 1")
        print("resultscount\(results.count)")
        //どのタスクも未選択の時、フラグを設定
        if (results.count == 0){
            try!realm.write{
                taskData.selectedFlg = 1
            }
            //他のタスクが選択状態の時、フラグを入れ替える
        }else if(results.count == 1 &&  taskData.selectedFlg == 0){
            let selectedTask = results[0]
            try!realm.write{
                selectedTask.selectedFlg = 0
                taskData.selectedFlg = 1
            }
        }else{
            return
        }
        tableView.reloadData()
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
