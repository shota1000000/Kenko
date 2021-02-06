//
//  UIViewController.swift
//  kenko
//
//  Created by 葛西　翔太 on 2021/01/30.
//  Copyright © 2021 葛西　翔太. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ViewController: UIViewController {
    var commentArray = [String]()
    var imageURLArray = [String]()
    var recipeTypeArray = [String]()
    var recordedDateArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        startParse()
        let indicatorView = NVActivityIndicatorView(frame: view.bounds)
        indicatorView.type = .orbit
        indicatorView.color = .darkGray
        indicatorView.alpha = 0.7
        indicatorView.backgroundColor = .black
        indicatorView.startAnimating()
        view.addSubview(indicatorView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            indicatorView.stopAnimating()
            indicatorView.removeFromSuperview()
        }
    }
    
    func startParse(){
        let urlString = "https://cooking-records.herokuapp.com/cooking_records?limit=47"
        let encodeUrlString:String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        AF.request(encodeUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            (response) in
            switch response.result{
            case .success:
                let json:JSON = JSON(response.data as Any)
                let resultCount:Int = json["pagination"]["total"].int!
                
                for i in 0 ..< resultCount{
                    //コメント
                    let comment = json["cooking_records"][i]["comment"].string
                    //画像データ
                    let imageURL = json["cooking_records"][i]["image_url"].string
                    //レシピ種別
                    let recipeType = json["cooking_records"][i]["recipe_type"].string
                    //登録日時
                    let recordedDate = json["cooking_records"][i]["recorded_at"].string
                    
                    if comment != nil{
                        self.commentArray.append(comment!)
                    }
                    if imageURL != nil{
                        self.imageURLArray.append(imageURL!)
                    }
                    if recipeType != nil{
                        self.recipeTypeArray.append(recipeType!)
                    }
                    if recordedDate != nil{
                        self.recordedDateArray.append(recordedDate!)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func albumButton(_ sender: Any) {
        performSegue(withIdentifier: "moveToCollection", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "moveToCollection"{
            let collectionVC = segue.destination as! CollectionViewController
            collectionVC.commentArray = self.commentArray
            collectionVC.imageURLArray = self.imageURLArray
            collectionVC.recipeTypeArray = self.recipeTypeArray
            collectionVC.recordedDateArray = self.recordedDateArray
        }
    }
}
