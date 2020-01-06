//
//  SpecificPersonViewController.swift
//  MayTheForceBeWith_Rafael_Santos
//
//  Created by ES-Team on 05/12/2019.
//  Copyright © 2019 Rafael Santos. All rights reserved.
//

import UIKit

class SpecificPersonViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    
    var name = ""
    var heigh = ""
    var mass = ""
    var gender = ""
    var hair = ""
    var skin = ""
    var eye = ""
    var birthYear = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.nameLabel.text = self.name
        self.heightLabel.text = self.heigh
        self.massLabel.text = self.mass
        self.genderLabel.text = self.gender
        self.hairColorLabel.text = self.hair
        self.skinColorLabel.text = self.skin
        self.eyeColorLabel.text = self.eye
        self.birthYearLabel.text = self.birthYear
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoCell
//        cell.nameLabel.text = personsArray[indexPath.row].name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showPersonSegue", sender: indexPath.row)
    }
    
    
}
