//
//  EditReViewController.swift
//  MoneySave
//
//  Created by mayuka on 2018/07/09.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit

class EditReViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tbl: UITableView!
    
    //セクション
    var sectionIndex:[String] = ["日付", "金額", "メモ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl.delegate = self
        self.tbl.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    //データの個数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath)
        // 値を設定する.
        cell.textLabel!.text = "Row \(indexPath.row)"
        return cell
    }
    
    //セクション名を返す
    func tableView(_ tableView:UITableView, titleForHeaderInSection section:Int) -> String?{
        return sectionIndex[section]
    }
    
    //セクションの個数を返す
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionIndex.count
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
