//
//  AddListViewController.swift
//  MoneySave
//
//  Created by mayuka on 2018/07/09.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit

class AddListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func AddList(_ sender: Any) {
        
    }
    
    
    //セクション
    var sectionIndex:[String] = ["目標内容","目標金額"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // データのないセルを表示しないようにする
        tableView.tableFooterView = UIView(frame: .zero)
        //セクションの高さ
        tableView.sectionHeaderHeight = 40;
        
        // Do any additional setup after loading the view.
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
        cell.textLabel!.text = "Row \(indexPath.row)"
        return cell
    }
    
    //セクションの色の設定を行う
    //func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let label : UILabel = UILabel()
        //label.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 1.0, alpha:1.0)
        //label.textColor = UIColor.black
        //label.text = sectionIndex[section]
        //return label
    //}
    
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
