//import Foundation
//
//struct CharacterManager{
//    let charURL = "https://rickandmortyapi.com/api/character/?name"
//
//    func performRequest(urlString:String){
////        let urlString = "\(charURL)=\(charName)"
//        if let url = URL(string: urlString){
//            let session = URLSession.shared
//
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil{
//                    print(error!)
//                    return
//                }
//                print("no error")
//                if let safeData = data {
//                    //                    let dataString = String(data: safeData, encoding: .utf8)
//                    self.parseJSON(characterData: safeData)
//                }
//
//            }
//            task.resume()
//        }
//    }
//
//    func parseJSON(characterData:Data){
//        let decoder = JSONDecoder()
//        do{
//            let downloadeData = try decoder.decode([CharacterData].self, from: characterData)
//
//            //self.chars = [downloadeData]
//            //print(self.chars[0].results[0])
//            //print(self.chars[0].results[0].name)
//            //print(self.chars[0].results.count)
//
////            DispatchQueue.main.async {
////                self.tableView.reloadData()
////            }
//        } catch {
//            print(error)
//        }
//
//    }
//}
