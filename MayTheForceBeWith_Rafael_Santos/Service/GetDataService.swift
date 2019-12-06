//
//  GetDataService.swift
//  MayTheForceBeWith_Rafael_Santos
//
//  Created by ES-Team on 04/12/2019.
//  Copyright © 2019 Rafael Santos. All rights reserved.
//

import Alamofire
import SwiftyJSON

class GetDataService {
    
    var delegate: PastJSONData?
    var URL : String = "https://swapi.co/api/"
    let queue = DispatchQueue.init(label: "com.rafaelcsantos.MayTheForceBeWith")

    func getData(type: String)
    {
        let url = "\(URL)\(type)"
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON {
           response in
           if response.result.isSuccess {
            self.queue.async {
                let jsonValues = JSON(response.result.value!)
                self.delegate?.starWarsData(value: jsonValues)
            }
           } else {
             print(response.result.error!)
           }
       }
    }
}

