//
//  URLBuilder.swift
//  LeagueViewer
//
//  Created by Student on 19.06.22.
//

import Foundation

final class URLBuilder {
    //Key from friend
    private var currentApiKey = "RGAPI-a1011b33-ff29-42f4-b2d1-c8f609d26dfe"
    //Development Key
    //private var currentApiKey = "RGAPI-0df2f0d9-01b2-459e-a10d-bc9c91771f14"
    
    func Summoner_v4(region: String, summonerName: String) -> String {
        let tmp = "https://" + region + ".api.riotgames.com/lol/summoner/v4/summoners/by-name/" + checkSummonerName(summonerName: summonerName) + "?api_key=" + currentApiKey
        debugPrint("URL used: " + tmp)
        return tmp
    }
    
    func Champion_Mastery_v4(region: String, summonerId: String) -> String {
        let tmp = "https://" + region + ".api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/" + summonerId + "?api_key=" + currentApiKey
        debugPrint("URL used: " + tmp)
        return tmp
    }
    
    func League_v4(region: String, summonerId: String) -> String {
        let tmp = "https://" + region + ".api.riotgames.com/lol/league/v4/entries/by-summmoner/" + summonerId + "?api_key=" + currentApiKey
        debugPrint("URL used: " + tmp)
        return tmp
    }
    
    func Match_v4(region: String, puuid: String, amount: String) -> String {
        let tmp = "https://" + generalizeRegion(region: region) + ".api.riotgames.com/lol/match/v5/matches/by-puuid/" + puuid + "/ids?start=0&count=" + amount + "&api_key=" + currentApiKey
        debugPrint("URL used: " + tmp)
        return tmp
    }
    
    func Match_v4_Match(region: String, matchId: String) -> String{
        let tmp = "https://" + generalizeRegion(region: region) + ".api.riotgames.com/lol/match/v5/matches/" + matchId + "?api_key=" + currentApiKey
        debugPrint("URL used: " + tmp)
        return tmp
    }
    
    func checkSummonerName(summonerName: String) -> String{
        if(summonerName.contains(" ")) {
            return summonerName.replacingOccurrences(of: " ", with: "%20")
        }
        else {
            return summonerName
        }
    }
    
    func generalizeRegion(region: String) -> String {
        if(region == "euw1" || region == "eune") {
            return "europe"
        }
        else if(region == "br1" || region == "la1" || region == "la2" || region == "na1") {
            return "americas"
        }
        else {
            return "asia"
        }
    }
}
