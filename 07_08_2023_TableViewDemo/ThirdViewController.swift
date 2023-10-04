//
//  ThirdViewController.swift
//  07_08_2023_TableViewDemo
//
//  Created by Vishal Jagtap on 04/10/23.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var dataContainer : Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    func bindData(){
        nameLabel.text = dataContainer?.firstName
    }
}
