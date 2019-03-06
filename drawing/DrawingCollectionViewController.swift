//
//  DrawingCollectionViewController.swift
//  drawing
//
//  Created by Apple on 2019/3/6.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit



class DrawingCollectionViewController: UICollectionViewController {
var draws = [Draw]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let draw = Draw.load() {
            if draw.count == 0 {
                let text = Draw.init(title: "今天吃什麼", questions: ["漢堡","牛肉","逼逼","豬肉","美味","沙拉","水果"])
                draws.append(text)
                let rr = Draw.init(title: "今天去哪裡", questions: ["上班","回家","看電影","逛街","夜店"])
                draws.append(rr)
                save()
                
            }else{
                draws = draw
                collectionView.reloadData()
            }
        }else{
            let text = Draw.init(title: "今天吃什麼", questions: ["漢堡","牛肉","逼逼","豬肉","美味","沙拉","水果"])
            draws.append(text)
            let rr = Draw.init(title: "今天去哪裡", questions: ["上班","回家","看電影","逛街","夜店"])
            draws.append(rr)
            save()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("draws.count = \(draws.count)")
        if let draws = Draw.load() {
            self.draws = draws
            print("draws.count2 = \(draws.count)")
        }
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        save()
        
    }
    func save (){
        Draw.sava(draws)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
         print("draws.countTVB = \(draws.count)")
        return draws.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! DrawingCollectionViewCell
    
        // Configure the cell
        let item = draws[indexPath.row]
        cell.quzLabel.text = item.title
        
        return cell
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
        collectionView.insertItems(at: [indexPath])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "VC"{
            let index = collectionView.indexPathsForSelectedItems?.first
            print(index?.row)
            let VC = segue.destination as! ViewController
            VC.draw = draws[(index?.row)!]
            VC.draws = draws
            VC.index = index?.row
            VC.sec = index?.section
        }
        
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
