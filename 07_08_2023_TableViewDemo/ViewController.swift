//
//  ViewController.swift
//  07_08_2023_TableViewDemo
//
//  Created by Vishal Jagtap on 03/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var studentTableView: UITableView!
    private let studentTableViewCellIdentifier : String = "StudentTableViewCell"
    private let secondViewControllerIdentifier : String = "SecondViewController"
    private let thirdViewControllerIdentifier : String = "ThirdViewController"
    
    var students : [Student] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        initializationOfTableView()
        registerCellWithTableView()
    }
    
    func initializationOfTableView(){
        studentTableView.dataSource = self
        studentTableView.delegate = self
    }
    
    func registerCellWithTableView(){
       let uiNib = UINib(nibName: studentTableViewCellIdentifier, bundle: nil)
        self.studentTableView.register(uiNib, forCellReuseIdentifier: studentTableViewCellIdentifier)
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: secondViewControllerIdentifier) as? SecondViewController
        secondViewController?.backDataPassDelegate = self
        navigationController?.pushViewController(secondViewController!, animated: true)
    }
}

extension ViewController : PassStudentDataToFVC{
    func passStudentData(student: Student) {
        students.append(student)
        self.studentTableView.reloadData()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentTableViewCell = self.studentTableView.dequeueReusableCell(withIdentifier: studentTableViewCellIdentifier, for: indexPath) as? StudentTableViewCell
        
        studentTableViewCell?.firstNameLabel.text = students[indexPath.row].firstName
        studentTableViewCell?.lastNameLabel.text = students[indexPath.row].lastName
        studentTableViewCell?.cityLabel.text = students[indexPath.row].city
        
        return studentTableViewCell ?? UITableViewCell()
    }
    
    //MARK : didSelectRowAt function implementation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let thirdViewController = self.storyboard?.instantiateViewController(withIdentifier: thirdViewControllerIdentifier) as? ThirdViewController
        
        thirdViewController?.dataContainer = students[indexPath.row]        //indexPath.row - this will return you the index of the row bwing clicked
        
        navigationController?.pushViewController(thirdViewController!, animated: true)
    }
    
    //MARK : deleting rows - swipe and delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            self.studentTableView.beginUpdates()
            self.studentTableView.deleteRows(
                at: [indexPath],
                with: .fade)
            self.students.remove(at: indexPath.row)
            self.studentTableView.endUpdates()
        }
    }
}

extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.0
    }
}
