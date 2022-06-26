//
//  Match_v4.swift
//  LeagueViewer
//
//  Created by Student on 25.06.22.
//

import Foundation

struct MatchDTO: Codable, Identifiable {
    let id = UUID()
    var metadata: MetaDataDTO
    var info: InfoDTO
}

struct MetaDataDTO: Codable {
    var dataVersion: String
    var matchId: String
    var participants: [String]
}

struct InfoDTO: Codable, Identifiable {
    let id = UUID()
    var gameCreation: CLong
    var gameDuration: CLong
    var gameEndTimestamp: CLong
    var gameId: CLong
    var gameMode: String
    var gameName: String
    var gameType: String
    var gameVersion: String
    var mapId: Int
    var participants: [ParticipantDTO]
    var platformId: String
    var queueId: Int
    var teams: [TeamDTO]
    var tournamentCode: String
}

struct ParticipantDTO: Codable, Identifiable {
    let id = UUID()
    var assists: Int
    var baronKills: Int
    var bountyLevel: Int
    var champExperience: Int
    var champLevel: Int
    var championId: Int
    var championName: String
    var championTransform: Int
    var consumablesPurchased: Int
    var damageDealtToBuildings: Int
    var damageDealtToObjectives: Int
    var damageDealtToTurrets: Int
    var damageSelfMitigated: Int
    var deaths: Int
    var detectorWardsPlaced: Int
    var doubleKills: Int
    var dragonKills: Int
    var firstBloodAssist: Bool
    var firstBloodKill: Bool
    var firstTowerAssist: Bool
    var firstTowerKill: Bool
    var gameEndedInEarlySurrender: Bool
    var gameEndedInSurrender: Bool
    var goldEarned: Int
    var goldSpent: Int
    var individualPosition: String
    var inhibitorKills: Int
    var inhibitorTakedowns: Int
    var inhibitorsLost: Int
    var item0: Int
    var item1: Int
    var item2: Int
    var item3: Int
    var item4: Int
    var item5: Int
    var item6: Int
    var itemsPurchased: Int
    var killingSprees: Int
    var kills: Int
    var lane: String
    var largestCriticalStrike: Int
    var largestKillingSpree: Int
    var largestMultiKill: Int
    var longestTimeSpentLiving: Int
    var magicDamageDealt: Int
    var magicDamageDealtToChampions: Int
    var magicDamageTaken: Int
    var neutralMinionsKilled: Int
    var nexusKills: Int
    var nexusTakedowns: Int
    var nexusLost: Int
    var objectivesStolen: Int
    var objectivesStolenAssists: Int
    var participantId: Int
    var pentaKills: Int
    var perks: PerksDTO
    var physicalDamageDealt: Int
    var physicalDamageDealtToChampions: Int
    var physicalDamageTaken: Int
    var profileIcon: Int
    var puuid: String
    var quadraKills: Int
    var riotIdName: String
    var riotIdTagline: String
    var role: String
    var sightWardsBoughtInGame: Int
    var spell1Casts: Int
    var spell2Casts: Int
    var spell3Casts: Int
    var spell4Casts: Int
    var summoner1Casts: Int
    var summoner1Id: Int
    var summoner2Casts: Int
    var summoner2Id: Int
    var summonerId: String
    var summonerLevel: Int
    var summonerName: String
    var teamEarlySurrendered: Bool
    var teamId: Int
    var teamPosition: String
    var timeCCingOthers: Int
    var timePlayed: Int
    var totalDamageDealt: Int
    var totalDamageDealtToChampions: Int
    var totalDamageShieldedOnTeammates: Int
    var totalDamageTaken: Int
    var totalHeal: Int
    var totalHealsOnTeammates: Int
    var totalMinionsKilled: Int
    var totalTimeCCDealt: Int
    var totalTimeSpentDead: Int
    var totalUnitsHealed: Int
    var tripleKills: Int
    var trueDamageDealtToChampions: Int
    var trueDamageTaken: Int
    var turretKills: Int
    var turretTakedowns: Int
    var turretsLost: Int
    var unrealKills: Int
    var visionScore: Int
    var visionWardsBoughtInGame: Int
    var wardsKilled: Int
    var wardsPlaced: Int
    var win: Bool
}

struct PerksDTO: Codable, Identifiable {
    let id = UUID()
    var statPerks: PerkStatsDTO
    var styles: [PerkStyleDTO]
}

struct PerkStatsDTO: Codable, Identifiable {
    let id = UUID()
    var defense: Int
    var flex: Int
    var offense: Int
}

struct PerkStyleDTO: Codable, Identifiable {
    let id = UUID()
    var description: String
    var selections: [PerkStyleSelectionDTO]
    var style: Int
}

struct PerkStyleSelectionDTO: Codable, Identifiable {
    let id = UUID()
    var perk: Int
    var var1: Int
    var var2: Int
    var var3: Int
}

struct TeamDTO: Codable, Identifiable {
    let id = UUID()
    var bans: [BanDTO]
    var objectives: ObjectivesDTO
    var teamId: Int
    var win: Bool
}

struct BanDTO: Codable, Identifiable {
    let id = UUID()
    var championId: Int
    var pickTurn: Int
}

struct ObjectivesDTO: Codable, Identifiable {
    let id = UUID()
    var baron: ObjectiveDTO
    var champion: ObjectiveDTO
    var dragon: ObjectiveDTO
    var inhibitor: ObjectiveDTO
    var riftHerald: ObjectiveDTO
    var tower: ObjectiveDTO
}

struct ObjectiveDTO: Codable, Identifiable {
    let id = UUID()
    var first: Bool
    var kills: Int
}

final class Match_v4 {
    
    func getMatchesArray(region: String, puuid: String, amount: String, completion: @escaping (Result<[String], ApiError>) -> ()) {
        //URL where data should be fetched from
        guard let url = URL(string: URLBuilder().Match_v4(region: region, puuid: puuid, amount: amount)) else { return }
        
        //Define call to be of type "GET"
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //let semaphore = DispatchSemaphore(value: 0) //semaphore1
        
        //Start the api call
        URLSession.shared.dataTask(with: request) { (data, response, _) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Code: \(httpResponse.statusCode)")
                
                //Error handling using the status codes
                if (httpResponse.statusCode != 200) { //Failed Link
                    completion(.failure(ApiError.requestFailed))
                }
                else {
                    let matches = try! JSONDecoder().decode([String].self, from: data!)
                    completion(.success(matches))
                }
            }
            //semaphore.signal() //semaphore2
        }
        .resume()
        
        //_ = semaphore.wait(wallTimeout: .distantFuture) //semaphore3
    }
    
    func getMatch(region: String, matchId: String, completion: @escaping (Result<MatchDTO, ApiError>) -> ()) {
        //URL where data should be fetched from
        guard let url = URL(string: URLBuilder().Match_v4_Match(region: region, matchId: matchId)) else { return }
        
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
                    let match = try! JSONDecoder().decode(MatchDTO.self, from: data!)
                    completion(.success(match))
                }
            }
            semaphore.signal() //semaphore2
        }
        .resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture) //semaphore3
    }
}
