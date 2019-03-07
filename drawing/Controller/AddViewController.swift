//
//  AddViewController.swift
//  drawing
//
//  Created by Apple on 2018/11/12.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class AddViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
    
    @IBOutlet var addVC: UIView!
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var addQuzTextField: UITextField!
    var draw = Draw.init(title: "", questions: [""])
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return draw.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! AddTableViewCell
        cell.addTextField.tag = indexPath.row
        return cell
    }
    
    //點擊textField 時觸發方法
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //結束textField編輯切換到點擊到下一個textField 或 馬上做其他事件時觸發
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let index = IndexPath(row: textField.tag, section: 0)
        
        print("index.row = \(index.row), \(textField.tag)")
        print("questions = \(draw.questions)")
    }
    //＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    //可以用textfield的action sender 來偵測現在是哪個cell被點擊 在用tag來取textfield的值
    
    @IBAction func addTextEditingChange(_ sender: UITextField) {
        
        print("\(#line) \(sender.tag) \(sender.text!)")
        
        draw.questions[sender.tag] = sender.text!
            updateSaveButtonState()
    }
    
    func updateSaveButtonState(){
        let drawTitle = addQuzTextField.text ?? ""
        let isDrawTitleExist = !drawTitle.isEmpty
        saveBtn.isEnabled = isDrawTitleExist
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            draw.questions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    @IBAction func addCellBtn(_ sender: Any) {
        
        let indexPath = IndexPath(row: draw.questions.count, section: 0)
        //將emoji 插入陣列
        draw.questions.append("")
        
        addTVC.insertRows(at: [indexPath], with: .automatic)
        print(draw.questions.count)
        
        
    }
    
    @IBOutlet weak var addTVC: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        // Do any additional setup after loading the view.
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "save" else {
            return
        }

        let indexPath = IndexPath(row: draw.questions.count, section: 0)
        
        let cell = addTVC.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! AddTableViewCell
        let drawTitle = addQuzTextField.text ?? ""
        let drawQuz = cell.addTextField.text ?? ""
        
//        let drawTVC = segue.destination as! DrawingTableViewController
//        let drawCV = segue.destination as! DrawingCollectionViewCell
        
        draw.title = addQuzTextField.text ?? ""
        
//        drawTVC.draws.append(draw)
        print("drawTitle = \(drawTitle)")
        

    }
    
    

}


