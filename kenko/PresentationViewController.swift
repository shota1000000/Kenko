//
//  PresentationViewController.swift
//  kenko
//
//  Created by 葛西　翔太 on 2021/02/02.
//  Copyright © 2021 葛西　翔太. All rights reserved.
//

import UIKit

class PresentationViewController: UIViewController {
    var comment = ""
    var image = ""
    var recipeType = ""
    var recordedDate = ""
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var recordedDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        dishImageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "noimage"), options: .continueInBackground, context: nil, progress: nil, completed: nil)
        commentTextView.text = comment
        recordedDateLabel.text = "記録日時：\(recordedDate)"
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
