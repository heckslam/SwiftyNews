//
//  AboutNewsVC.swift
//  Pr8
//
//  Created by Руслан Алиев on 14.11.2017.
//  Copyright © 2017 DEVTRON. All rights reserved.
//

import UIKit

class AboutNewsVC: UIViewController {
    
    @IBOutlet weak var aboutTv: UITextView!
    @IBOutlet weak var categoryTv: UILabel!
    @IBOutlet weak var titleTv: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateTv: UILabel!
    
    var item: ItemNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTv.text = item?.title
        imageView.sd_setImage(with: URL(string: (item?.photo)!), placeholderImage: UIImage(named: "placeholder"))
        
        dateTv.text = item?.date
        categoryTv.text = item?.rubric
    }
}
