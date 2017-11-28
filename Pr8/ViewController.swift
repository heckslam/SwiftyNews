//
//  ViewController.swift
//  Pr8
//
//  Created by Руслан Алиев on 02.11.17.
//  Copyright © 2017 DEVTRON. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var arrayNews: [ItemNews]  = []
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Новости"
        arrayNews = SplashViewController.arrayNews
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.reloadData()
    }
    
    //как будет выглядеть один элемент
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CustomCell
        
        cell.title.text = arrayNews[indexPath.row].title
        cell.imageViewNews.sd_setImage(with: URL(string: arrayNews[indexPath.row].photo), placeholderImage: UIImage(named: "placeholder"))
        
        cell.date.text = arrayNews[indexPath.row].date
        cell.category.text = arrayNews[indexPath.row].rubric
        
        return cell
    }

    
    //сколько будет
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNews.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutNewsVC") as! AboutNewsVC
        vc.item = arrayNews[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

