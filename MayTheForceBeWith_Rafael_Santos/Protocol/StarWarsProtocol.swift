//
//  StarWarsProtocol.swift
//  MayTheForceBeWith_Rafael_Santos
//
//  Created by ES-Team on 04/12/2019.
//  Copyright © 2019 Rafael Santos. All rights reserved.
//

import SwiftyJSON

protocol PastJSONData {
    func starWarsData(value: JSON)
    func nextValidation(stringValue: String)
}
