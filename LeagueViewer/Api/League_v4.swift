//
//  League_v4.swift
//  LeagueViewer
//
//  Created by Student on 19.06.22.
//

import Foundation

struct LeagueEntryDTO: Codable, Identifiable {
    let id = UUID()
    var leagueId: String
    var summonerId: String
    var summonerName: String
    var queueType: String
    var tier: String
    var rank: String
    var leaguePoints: Int
    var wins: Int
    var losses: Int
    var hotStreak: Bool
    var veteran: Bool
    var freshBlood: Bool
    var inactive: Bool
    //var miniSeries: MiniSeriesDTO
}

struct MiniSeriesDTO: Codable {
    var losses: Int
    var progress: String
    var target: Int
    var wins: Int
}

final class League_v4 {
    
    func getProfile(region: String, summonerId: String, completion: @escaping (Result<[LeagueEntryDTO], ApiError>) -> ()) {
        //URL where data should be fetched from
        guard let url = URL(string: URLBuilder().League_v4(region: region, summonerId: summonerId)) else { return }
        
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
                    let profile = try! JSONDecoder().decode([LeagueEntryDTO].self, from: data!)
                    completion(.success(profile))
                }
            }
            semaphore.signal() //semaphore2
        }
        .resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture) //semaphore3
    }
}
