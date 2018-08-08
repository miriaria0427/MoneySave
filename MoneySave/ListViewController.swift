//
//  ListViewController.swift
//  MoneySave
//
//  Created by mayuka on 2018/07/09.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tbl: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl.delegate = self
        self.tbl.dataSource = self
        
        //Identiferを設定
        self.tbl.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        
        // テーブル行の高さをAutoLayoutで自動調整する
        //tbl.rowHeight = UITableViewAutomaticDimension
        // テーブル行の高さの概算値を設定しておく
        // 高さ概算値
        //tbl.estimatedRowHeight = UIScreen.main.bounds.width + 40

        // Do any additional setup after loading the view.
    }
    
    //データの個数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        // 値を設定する.
        cell.MokuhyoCellLabel!.text = "目標 \(indexPath.row)"
        return cell
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
