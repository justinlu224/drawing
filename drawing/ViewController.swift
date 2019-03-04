//
//  ViewController.swift
//  drawing
//
//  Created by Apple on 2018/10/31.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import AVFoundation

struct DrawItem {
    let number:String?
    let drawName:String?
}

class ViewController: UIViewController, AVAudioPlayerDelegate ,UITableViewDataSource,UITableViewDelegate  {
    @IBOutlet weak var drawingSV: UIStackView!
    @IBOutlet weak var drawingTableView: UITableView!
    
    @IBOutlet weak var drawingLabel: UILabel!
    @IBOutlet var topView: UIView!
    
    
    
    var draw:Draw?
    var index:Int?
    var sec:Int?
    let drawTVC = drawingTableViewController()
    var draws = [Draw]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       drawingTableView.dataSource = self
        drawingTableView.delegate = self 
        UIApplication.shared.applicationSupportsShakeToEdit = true
      //
//        draw?.questions.append("")
        if let draws = Draw.load() {
            self.draws = draws
        }
       
    }

    @IBAction func button(_ sender: Any) {
        
        UIView.animateKeyframes(withDuration: 0, delay: 0, options: UIView.KeyframeAnimationOptions.beginFromCurrentState, animations: { () -> Void in
            
            //            self.drawingSV.frame.origin.y -= 200
            
            self.drawingSV.frame = CGRect(x: -50, y: -80, width: 0, height: 0)
            
            
            
        }, completion: nil)
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("开始摇动")
        
        
        
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: UIView.KeyframeAnimationOptions.beginFromCurrentState, animations: { () -> Void in
            
//            self.drawingSV.frame.origin.y -= 200
            
            
            self.drawingSV.frame = CGRect(x: self.topView.bounds.width/3, y: self.topView.bounds.height/3, width: 0, height: 0)
            
            
            
        }, completion: nil)
        
    }
    /**
     取消摇动
     */
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("取消摇动")
        
    }
    
    /**
     摇动结束
     
     */
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("摇动结束")
        ///此处设置摇一摇需要实现的功能
        let aa = Int.random(in: 0..<(draw?.questions.count)!)
        drawingLabel.text = String(aa)
        print(draw?.questions[aa])
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func unwindToVC(_ segue: UIStoryboardSegue){
        
        guard segue.identifier == "save" else {
            return
        }
        drawingTableView.reloadData()
        
        draws[sec!] = draw!
        
        drawTVC.draws = draws
        Draw.sava(draws)
//        drawTVC.save()
//        let source = segue.source as! AddViewController
//        
//        let draw = source.draw
//        
//        let indexPath = IndexPath(row: draws.count, section: 0)
//        //將emoji 插入陣列
//        draws.append(draw)
//        save()
//        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return (draw?.questions.count)!
        return draws[index!].questions.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
        print("sec = \(index!)")
        let item = draws[index!].questions[indexPath.row]
        print(item)
        cell.textLabel?.text = String(indexPath.row)
        cell.detailTextLabel?.text = item
//        let item = drawItem[indexPath.row]
//        cell.textLabel?.text = item.drawName
        
     return cell
     }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == "edit"{
            let editVC = segue.destination as! EditViewController
            editVC.draw = draw
        }
       
        
        
     }
    

}

