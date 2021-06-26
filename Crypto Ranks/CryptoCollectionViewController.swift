//
//  CryptoCollectionViewController.swift
//  Crypto Ranks
//
//  Created by Xavier Jones on 6/25/21.
//

import UIKit

class CryptoCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let reuseIdentifier = "cell"
    
    //Array to test out collection view before implementing API.
    let items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36"]
    
    @IBOutlet weak var cryptoCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cryptoCollection.setCollectionViewLayout(generateLayout(), animated: false)
        // Do any additional setup after loading the view.
       // collectionView!.register(CryptoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func generateLayout() -> UICollectionViewLayout{
        //This sets the spacing for the items and arrangement in the collection view
        let spacing: CGFloat = 5.0
        
        //Establsihes and sets the size for each row item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        //Establishes and sets the sizes for each group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        //Establishes and sets the sizes for the section and connects it to the group.
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CryptoCollectionViewCell
        
        //Edits the appearance of the collection view items
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOpacity = 0.25
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    //Handles touch input for the collection view.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(items[indexPath.item])
        performSegue(withIdentifier: "cryptoDetailsSegue", sender: self)
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
