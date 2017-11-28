//
//  SplashViewController.swift
//  Pr8
//
//  Created by Руслан Алиев on 09.11.2017.
//  Copyright © 2017 DEVTRON. All rights reserved.
//

import UIKit
import Alamofire

class SplashViewController: UIViewController {
    
    static var arrayNews: [ItemNews]  = []
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress.startAnimating()
        
        getListNews()
    }
    
    //метод для загрузки новостей
    func getListNews () {
        
        let urlString = "http://app.cre.ru/api8/newsList"
        
        Alamofire.request(urlString, method: .get, parameters: nil).responseJSON(completionHandler: { (response) in
            
            //приходит ответ
            if response.result.isSuccess {
                do {
                    //переводим то что пришло в json
                    let readableJson = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? NSDictionary
                    
                    //получаем из json массив data
                    if let blogs = readableJson?["data"] as? [[String: AnyObject]] {
                        //отправляем массив на парсинг
                        self.parse(blogs: blogs)
                    } else {
                        //сообщение об ошибке если не смогли достать из json массив data
                         self.showError()
                        print(response.result)
                    }
                } catch {
                    //сообщение об ошибке
                     self.showError()
                    print(error.localizedDescription)
                }
            } else {
                //сообщение об ошибке
                self.showError()
                print("response result isFailure = \(response.result.error)")
            }
            
        })
    }
    
    //метод для парсинга новостей
    func parse (blogs: [[String: AnyObject]]) {
        
        for blog in blogs {
            
            let newItem = ItemNews()
            
            if let id = blog["id"] as? Int {
                newItem.id = id
            }
            
            if let title = blog["title"] as? String {
                newItem.title = title
                print(title)
            }
            
            if let date = blog["date"] as? String {
                newItem.date = date
            }
            
            if let rubric = blog["rubric"] as? String {
                newItem.rubric = rubric
            }
            
            if let photo = blog["image"] as? String {
                newItem.photo = photo
            }
            
            SplashViewController.arrayNews.append(newItem)
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsNavController") as! NewsNavigationController
        self.present(vc, animated: true, completion: nil)
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Ошибка", message:
            "При загрузке данных произошла ошибка, попробуйте снова", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default,
                                                handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
