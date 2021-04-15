//
//  MyViewController.swift
//  TableViewProject
//
//  Created by kooapps on 4/15/21.
//

import UIKit

class MyViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
   
    

    let list: [(title: String, des: String)] = [
        ("蹹山", "3是"),
        ("滑ㄖㄩㄝˋ", "6至"),
        ("打ㄗㄧㄡˊ", "9次"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let upLabel = cell.viewWithTag(100) as! UILabel
        let bottomLabel = cell.viewWithTag(200) as! UILabel
        
        upLabel.text = list[indexPath.row].title
        bottomLabel.text = list[indexPath.row].des
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
