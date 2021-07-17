//
//  EpisodeManager.swift
//  ricknmorty
//
//  Created by Samridh Agarwal on 17/07/21.
//

import Foundation

protocol EpisodeManagerDelegate{
    
    func didUpdateEpisode(_ episodeManager:EpisodeManager , _ weather: [EpisodeData])
    func didEncounterError(_ error: Error)
}

struct EpisodeManager{
    
    let url:String = "https://rickandmortyapi.com/api/episode"
    
    var delegate:EpisodeManagerDelegate?
    
    func getDetailsOfEpisodes(_ episodeNo: String){
        let finalUrl = "\(url)/\(episodeNo)"
        performRequest(finalUrl)
    }
    func performRequest(_ url: String)  {
        if let finalUrl = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: finalUrl) { data , urlResponce , error  in
                if(error == nil){
                    if let safeData = data{
                        if let seasons = self.parseJson(safeData){
                            self.delegate?.didUpdateEpisode(self, seasons)
                        }
                    }
                }
                if(error != nil){
                    self.delegate?.didEncounterError(error!)
                    return
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ data: Data)->[EpisodeData]? {
        do{
            let decodedData =  try JSONDecoder().decode(EpisodeData.self, from: data)
            let seasons = [decodedData]
            let rows = seasons[0].results.count
            return seasons
        }
        catch{
            self.delegate?.didEncounterError(error)
            return nil
        }
        
    }
    
    
    
    
}
