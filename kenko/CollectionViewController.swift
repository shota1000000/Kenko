//
//  CollectionViewController.swift
//  kenko
//
//  Created by 葛西　翔太 on 2021/01/30.
//  Copyright © 2021 葛西　翔太. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let image_max = 47
    var commentArray = [String]()
    var imageURLArray = [String]()
    var recipeTypeArray = [String]()
    var recordedDateArray = [String]()
    var comment = ""
    var image = ""
    var recipeType = ""
    var recordedDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image_max
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.sd_internalSetImage(with: URL(string: imageURLArray[indexPath.row]), placeholderImage: UIImage(named: "noimage"), options: .continueInBackground, context: nil, setImageBlock: nil, progress: nil, completed: nil)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.sd_setImage(with: URL(string: imageURLArray[indexPath.row]), placeholderImage: UIImage(named: "noimage"), options: .continueInBackground, context: nil, progress: nil, completed: nil)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        comment = commentArray[indexPath.row]
        image = imageURLArray[indexPath.row]
        recipeType = recipeTypeArray[indexPath.row]
        recordedDate = recordedDateArray[indexPath.row]
        performSegue(withIdentifier: "moveToPresentation", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToPresentation"{
            let presentationVC = segue.destination as! PresentationViewController
            presentationVC.comment = self.comment
            presentationVC.image = self.image
            presentationVC.recipeType = self.recipeType
            presentationVC.recordedDate = self.recordedDate
        }
    }
}
