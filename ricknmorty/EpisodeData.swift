//
//  EpisodeData.swift
//  ricknmorty
//
//  Created by Harsh  on 16/07/21.
//

import Foundation
struct EpisodeData:Decodable{
    let info:Info2 //cant use "Info" because already used in CharacterData
    let results:[Results2]
}

struct Info2:Decodable{
    let count:Int
}

struct Results2:Decodable{
    let id:Int
    let name:String
    let episode:String
    let characters:[String]
}
