//
//  Summoner_v4.swift
//  LeagueViewer
//
//  Created by Student on 19.06.22.
//

import Foundation

struct SummonerDTO: Codable {
    var accountId: String
    var profileIconId: Int
    var revisionDate: CLong
    var name: String
    var id: String
    var puuid: String
    var summonerLevel: CLong
    
    init() {
        accountId = ""
        profileIconId = 0
        revisionDate = 0
        name = ""
        id = ""
        puuid = ""
        summonerLevel = 0
    }
}

final class Summoner_v4 {
    
    func getSummoner(region: String, summonerName: String, completion: @escaping (Result<SummonerDTO, ApiError>) -> ()) {
        //URL where data should be fetched from
        guard let url = URL(string: URLBuilder().Summoner_v4(region: region, summonerName: summonerName)) else { return }
        
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
                    let summoner = try! JSONDecoder().decode(SummonerDTO.self, from: data!)
                    completion(.success(summoner))
                }
            }
            semaphore.signal() //semaphore2
        }
        .resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture) //semaphore3
    }
}
