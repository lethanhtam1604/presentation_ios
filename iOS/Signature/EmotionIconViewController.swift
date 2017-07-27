//
//  EmotionIconViewController.swift
//  Signature
//
//  Created by Thanh-Tam Le on 11/25/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import UIKit

class EmotionIconViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var emotionIconCollectionView: UICollectionView!
    private var emotionCellReuseIdentifier = "EmotionCellReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        emotionIconCollectionView.delegate = self
        emotionIconCollectionView.dataSource = self
        emotionIconCollectionView.register(UINib(nibName: "EmotionIconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: emotionCellReuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = EmotionIconManager.getInstance().emotionIconList.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EmotionIconCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: emotionCellReuseIdentifier as String, for: indexPath) as! EmotionIconCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
}
