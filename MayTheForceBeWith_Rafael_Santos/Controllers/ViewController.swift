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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, PastJSONData {

    // IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewToView: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var footerButtonView: UIView!
    @IBOutlet weak var searchBarButton: UIButton!
    
    // Array's
    var personsArray : [Person] = []
    var filterData : [Person] = []
    var nameArray : [String] = []
    
    let dataModel = GetDataService()
    var nextCall = "https://swapi.co/api/people/?format=json&page=1"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // searchBar
        searchBar.isHidden = true
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.tintColor = .white

        
        // tableView
        tableView.dataSource = self
        tableView.delegate = self
        
        // dataModel
        dataModel.delegate = self
        dataModel.getData(url: nextCall)
    }

    
    // MARK: - Functions
    
    // MARK: Atribute Person
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
    
    // MARK: Clear Search Bar
    func clearSearchBar() {
        searchBar.text = ""
        searchBar.endEditing(true)
        filterData = []
        nameArray = []
        tableView.reloadData()
    }
    
    // MARK: Clear Search Bar
    func attributedPerson(destVC: SpecificPersonViewController, personArray: [Person],positionOfArray: Int ) {
        destVC.name = personArray[positionOfArray].name
        destVC.heigh = personArray[positionOfArray].height
        destVC.mass = personArray[positionOfArray].mass
        destVC.hair = personArray[positionOfArray].hair_color
        destVC.gender = personArray[positionOfArray].gender
        destVC.skin = personArray[positionOfArray].skin_color
        destVC.eye = personArray[positionOfArray].eye_color
        destVC.birthYear = personArray[positionOfArray].birth_year
    }
    
    // MARK: - Button Action
    @IBAction func showMore(_ sender: Any) {
        dataModel.getData(url: nextCall)
    }
    
    @IBAction func showSearchBar(_ sender: Any) {
        self.searchBar.isHidden = !self.searchBar.isHidden
        
        if self.searchBar.isHidden {
            self.tableViewToView.constant = 0
            clearSearchBar()
        } else {
            self.tableViewToView.constant = self.searchBar.frame.height
            self.searchBar.becomeFirstResponder()
        }
    }
    
    // MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        nameArray = []
        filterData = []
        
        let string = searchBar.text
        let newString = string?.replacingOccurrences(of: " ", with: "")
        for person in self.personsArray {
            if person.name.contains(newString!) {
                if !nameArray.contains(newString!) {
                    filterData.append(person)
                    nameArray.append(person.name)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarButton.sendActions(for: .touchUpInside)
    }
    
    // MARK: - Protocols
    func starWarsData(value: JSON) {
        getSpecificPerson(data: value)
    }
    
    func nextValidation(stringValue: String) {
        DispatchQueue.main.async {
            if stringValue != "" {
                self.nextCall = stringValue
            } else {
                self.footerButtonView.isHidden = true
            }
        }
    }
     
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterData.count != 0 {
            return filterData.count
       } else {
           return personsArray.count
       }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoCell
        
        if filterData.count != 0 {
            cell.nameLabel.text = filterData[indexPath.row].name
        } else {
            cell.nameLabel.text = personsArray[indexPath.row].name
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showPersonSegue", sender: indexPath.row)
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showPersonSegue" {
            let positionOfArray = sender as! Int
            let destVC = segue.destination as! SpecificPersonViewController
            
            if filterData.count != 0 {
                attributedPerson(destVC: destVC, personArray: filterData, positionOfArray: positionOfArray)
            } else {
                attributedPerson(destVC: destVC, personArray: personsArray, positionOfArray: positionOfArray)
            }
        }
    }

}
