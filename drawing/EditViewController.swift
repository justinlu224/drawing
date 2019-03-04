//
//  EditViewController.swift
//  drawing
//
//  Created by Apple on 2018/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class EditViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var draw:Draw?
    @IBOutlet weak var editTVC: UITableView!
    @IBOutlet weak var editTitleTextField: UITextField!
    @IBOutlet weak var editSaveBtn: UIBarButtonItem!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (draw?.questions.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = editTVC.dequeueReusableCell(withIdentifier: "editCell", for: indexPath) as! EditTableViewCell
        editTitleTextField.text = draw?.title
        cell.editTextField.text = draw?.questions[indexPath.row]
        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addEditCell(_ sender: UIButton) {
        let indexPath = IndexPath(row: draw!.questions.count, section: 0)
        //將emoji 插入陣列
        draw!.questions.append("")
        
        editTVC.insertRows(at: [indexPath], with: .automatic)
        print(draw!.questions.count)
    }
    @IBAction func editTitleCditingChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func editQuzEditingChange(_ sender: UITextField) {
        
        draw!.questions[sender.tag] = sender.text!
    }
    
    func updateSaveButtonState(){
        let drawTitle = editTitleTextField.text ?? ""
        let isDrawTitleExist = !drawTitle.isEmpty
        editSaveBtn.isEnabled = isDrawTitleExist
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            draw!.questions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard segue.identifier == "save" else {
            return
        }
        let VC = segue.destination as! ViewController
        
        VC.draw = draw
    }
    

}
