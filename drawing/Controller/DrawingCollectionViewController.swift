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
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        // Do any additional setup after loading the view.
        if let draw = Draw.load() {
            if draw.count == 0 {
                let text = Draw.init(title: "今天吃什麼", questions: ["漢堡","牛排","拉麵","豬肉","斷食","沙拉","水果"])
                draws.append(text)
                let rr = Draw.init(title: "今天去哪裡", questions: ["上班","回家","看電影","逛街","夜店"])
                draws.append(rr)
                save()
                
            }else{
                draws = draw
                collectionView.reloadData()
            }
        }else{
            let text = Draw.init(title: "今天吃什麼", questions: ["漢堡","牛排","拉麵","豬肉","斷食","沙拉","水果"])
            draws.append(text)
            let rr = Draw.init(title: "今天去哪裡", questions: ["上班","回家","看電影","逛街","夜店"])
            draws.append(rr)
            save()
        }
    }
    func setDeleteBtnHidden(bool:Bool){
        if let indexPaths = collectionView?.indexPathsForVisibleItems{
            for indexPath in indexPaths{
                if let cell = collectionView.cellForItem(at: indexPath)as? DrawingCollectionViewCell{
                    cell.isEditing = bool
                }
            }
        }
    }
    // MARK:- setEditAction
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addBarButtonItem.isEnabled = !editing
        setDeleteBtnHidden(bool: editing)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let draws = Draw.load() {
            self.draws = draws
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        save()
    }
    
    func save (){
        Draw.sava(draws)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        print("draws.countTVB = \(draws.count)")
        return draws.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! DrawingCollectionViewCell
        
        // Configure the cell
        let item = draws[indexPath.row]
        cell.quzLabel.text = item.title
        cell.delegate = self
 
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
        collectionView.insertItems(at: [indexPath])
        save()
        setDeleteBtnHidden(bool: false)
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
            
        }
        
    }
    
}
extension DrawingCollectionViewController:DrawingCellDelegate{
    func delete(cell: DrawingCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell){
            draws.remove(at: indexPath.item)
            //            collectionView.reloadData()
            collectionView.deleteItems(at: [indexPath])
            save()
        }
    }
}
