//
//  ViewController.swift
//  MayTheForceBeWith_Rafael_Santos
//
//  Created by ES-Team on 03/12/2019.
//  Copyright © 2019 Rafael Santos. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PastJSONData {

    @IBOutlet weak var tableView: UITableView!

    let dataModel = GetDataService()
    var personsArray : [Person] = []
    var specificPerson : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        dataModel.delegate = self

        dataModel.getData(type: "people")
    }

    // MARK: - Atribute Person
    func getSpecificPerson(data: JSON){
        DispatchQueue.main.async {
            for person in data["results"].arrayValue {
                let info = Person(
                    name: person["name"].stringValue,
                    height: person["height"].stringValue,
                    mass: person["mass"].stringValue,
                    hair_color: person["hair_color"].stringValue,
                    skin_color: person["skin_color"].stringValue,
                    eye_color: person["eye_color"].stringValue,
                    birth_year: person["birth_year"].stringValue,
                    gender: person["gender"].stringValue
                )
                self.personsArray.append(info)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Protocols
    func starWarsData(value: JSON) {
        getSpecificPerson(data: value)
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return personsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoCell
        cell.nameLabel.text = personsArray[indexPath.row].name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showPersonSegue", sender: indexPath.row)
    }
        
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showPersonSegue" {
            DispatchQueue.main.async {
                let positionOfArray = sender as! Int
                
                let destVC = segue.destination as! SpecificPersonViewController
                destVC.name = self.personsArray[positionOfArray].name
                destVC.heigh = self.personsArray[positionOfArray].height
                destVC.mass = self.personsArray[positionOfArray].mass
                destVC.gender = self.personsArray[positionOfArray].gender
                destVC.skin = self.personsArray[positionOfArray].skin_color
                destVC.eye = self.personsArray[positionOfArray].eye_color
                destVC.birthYear = self.personsArray[positionOfArray].birth_year
            }
        }
    }

}
