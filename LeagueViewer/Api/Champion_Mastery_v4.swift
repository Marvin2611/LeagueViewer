//
//  Champion_Mastery_v4.swift
//  LeagueViewer
//
//  Created by Student on 19.06.22.
//

import Foundation

struct ChampionMasterDTO: Codable, Identifiable {
    let id = UUID()
    var championPointsUntilNextLevel: CLong
    var chestGranted: Bool
    var championId: CLong
    var lastPlayTime: CLong
    var championLevel: Int
    var summonerId: String
    var championPoints: Int
    var championPointsSinceLastLevel: CLong
    var tokensEarned: Int
}

final class Champion_Mastery_v4 {
    
    func getChampions(region: String, summonerId: String, completion: @escaping (Result<[ChampionMasterDTO], ApiError>) -> ()) {
        //URL where data should be fetched from
        guard let url = URL(string: URLBuilder().Champion_Mastery_v4(region: region, summonerId: summonerId)) else { return }
        
        //Define call to be of type "GET"
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let semaphore = DispatchSemaphore(value: 0) //semaphore1
        
        //Start the api call
        URLSession.shared.dataTask(with: request) { (data, response, _) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Code: \(httpResponse.statusCode)")
                
                //Error handling using the status codes
                if (httpResponse.statusCode != 200) { //Failed Link
                    completion(.failure(ApiError.requestFailed))
                }
                else {
                    let champions = try! JSONDecoder().decode([ChampionMasterDTO].self, from: data!)
                    completion(.success(champions))
                }
            }
            semaphore.signal() //semaphore2
        }
        .resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture) //semaphore3
    }
}
