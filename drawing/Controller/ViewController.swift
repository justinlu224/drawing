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
    @IBOutlet weak var drawingImageView: UIImageView!
    @IBOutlet weak var resuleNumLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resuleLable: UILabel!
    
    var draw:Draw?
    var index:Int?
    let drawTVC = DrawingTableViewController()
    var draws = [Draw]()
    var strtX:CGFloat?
    var strtY:CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       drawingTableView.dataSource = self
        drawingTableView.delegate = self 
        UIApplication.shared.applicationSupportsShakeToEdit = true
        resultView.layer.cornerRadius = resultView.bounds.width / 8.0
        
      
//        draw?.questions.append("")
        if let draws = Draw.load() {
            self.draws = draws
        }
        drawingSV.frame = CGRect(x: drawingImageView.center.x, y: drawingImageView.center.y, width: 0, height: 0)
        strtX = drawingSV.frame.maxX
        strtY = drawingSV.frame.maxY
        print("x.y = \(strtX!),\(strtY!) ")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }


    @IBAction func button(_ sender: Any) {
       resuleNumLabel.isHidden = true
        resultView.isHidden = true
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: UIView.KeyframeAnimationOptions.beginFromCurrentState, animations: { () -> Void in

            //            self.drawingSV.frame.origin.y -= 200

            self.drawingSV.frame = CGRect(x: self.strtX! , y: self.strtY!, width: 0, height: 0)



        }, completion: nil)
        
//        UIView.animate(withDuration: 0.5) {
//            self.drawingSV.transform = .identity
//        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("开始摇动")
        
        if !self.resultView.isHidden{
            return
        }
        
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: UIView.KeyframeAnimationOptions.beginFromCurrentState, animations: { () -> Void in

//            self.drawingSV.frame.origin.y -= 200


//            self.drawingSV.frame = CGRect(x: self.topView.bounds.width/3, y: self.topView.bounds.height/3, width: 0, height: 0)
            self.drawingSV.frame = CGRect(x: self.topView.frame.width/2 - self.drawingSV.bounds.width/2, y: self.topView.bounds.height/4, width: 0, height: 0)

//            self.drawingSV.transform = CGAffineTransform(translationX: 0, y: 0)
//            let aa = Int.random(in: 0..<(self.draw?.questions.count)!)
//            self.drawingLabel.text = String(aa)
//            print(self.draw?.questions[aa])


        }){(completion)in
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                print(self.draw ?? 1)
                print("draw = \(String(describing: self.draw?.questions.count))")
                let aa = Int.random(in: 0..<(self.draw?.questions.count)!)
                print(aa)
                self.resuleNumLabel.text = String(aa)
                self.resuleLable.text = self.draw?.questions[aa]
                self.resultView.isHidden = false
                self.resuleNumLabel.isHidden = false
            })
            
            
            
//            self.drawingLabel.isEnabled = true
//                    self.drawingLabel.text = String(aa)
//            self.drawingLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        }
        
        
//        let aa = Int.random(in: 0..<(self.draw?.questions.count)!)
//        self.drawingLabel.text = String(aa)
//        print(self.draw?.questions[aa])
//
//        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
//
//            self.drawingSV.frame = CGRect(x: self.topView.bounds.width/2, y: 200, width: 0, height: 0)
//
//
//
//        }
//        animator.startAnimation()
////        let aa = Int.random(in: 0..<(self.draw?.questions.count)!)
////                    self.drawingLabel.text = String(aa)
////                    print(self.draw?.questions[aa])
        
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
//    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        print("摇动结束")
//        ///此处设置摇一摇需要实现的功能
//        let aa = Int.random(in: 0..<(draw?.questions.count)!)
//        drawingLabel.text = String(aa)
//        print(draw?.questions[aa])
//
//
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func unwindToVC(_ segue: UIStoryboardSegue){
        
        guard segue.identifier == "save" else {
            return
        }
        
        
        draws[index!] = draw!
        
        drawTVC.draws = draws
        Draw.sava(draws)
        drawingTableView.reloadData()
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

