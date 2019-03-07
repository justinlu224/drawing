//
//  DrawingTableViewController.swift
//  drawing
//
//  Created by Apple on 2018/11/1.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class DrawingTableViewController: UITableViewController  {
    var draws = [Draw]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let draw = Draw.load() {
            if draw.count == 0 {
                let text = Draw.init(title: "今天吃什麼", questions: ["漢堡","牛排","泡麵","豬肉","斷食","沙拉","水果"])
                draws.append(text)
                let rr = Draw.init(title: "今天去哪裡", questions: ["上班","回家","看電影","逛街","夜店"])
                draws.append(rr)
                save()
                
            }else{
                draws = draw
                tableView.reloadData()
            }
        }else{
            let text = Draw.init(title: "今天吃什麼", questions: ["漢堡","牛排","泡麵","豬肉","斷食","沙拉","水果"])
            draws.append(text)
            let rr = Draw.init(title: "今天去哪裡", questions: ["上班","回家","看電影","逛街","夜店"])
            draws.append(rr)
            save()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        save()
       
    }
    
    @IBAction func unwindToList(_ segue: UIStoryboardSegue){
        
        guard segue.identifier == "save" else {
            return
        }
        let source = segue.source as! AddViewController
        
        let draw = source.draw 
        
        let indexPath = IndexPath(row: draws.count, section: 0)
        //將emoji 插入陣列
        draws.append(draw)
        save()
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func save (){
        Draw.sava(draws)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("draws.count = \(draws.count)")
        if let draws = Draw.load() {
            self.draws = draws
              print("draws.count2 = \(draws.count)")
        }
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("draws.countTVB = \(draws.count)")
        return draws.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        // Configure the cell...
        let item = draws[indexPath.row]
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            draws.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Draw.sava(draws)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "VC"{
            let index = tableView.indexPathForSelectedRow
            let VC = segue.destination as! ViewController
            VC.draw = draws[(index?.row)!]
            VC.draws = draws
            VC.index = index?.row
        }
        
    }
}


