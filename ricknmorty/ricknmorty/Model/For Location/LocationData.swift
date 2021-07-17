//
//  LocationData.swift
//  ricknmorty
//
//  Created by Harsh  on 15/07/21.
//

import Foundation

struct LocationData:Codable{
    let info: Infoo
    let results:[Resultss]
}

struct Infoo:Codable{
    let count:Int
}

struct Resultss:Codable{
    let id:Int
    let name:String
    let type:String
    let dimension:String
    let residents:[String]
    let url:String
}



