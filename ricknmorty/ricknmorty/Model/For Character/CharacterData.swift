//
//  CharacterData.swift
//  ricknmorty
//
//  Created by Harsh  on 06/07/21.
//

import Foundation
struct CharacterData:Codable{
    let info: Info
    let results:[Results]
    
}

struct Info:Codable{
    let count:Int
}

struct Results:Codable{
    let id:Int
    let name:String
    let status:String
    let species:String
    let gender:String
    let origin:Origin
    let location:Location
    let image: String
}

struct Origin:Codable {
    let name:String
}

struct  Location:Codable {
    let name:String
}


//MARK:////////////////////////////////////////////////////////////////////////////////////
