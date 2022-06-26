//
//  MatchesViewModel.swift
//  LeagueViewer
//
//  Created by Student on 25.06.22.
//

import Foundation

final class MatchesViewModel : ObservableObject {
    var summoner: SummonerDTO = SummonerDTO()
    var region = ""
    
    //Value needs to be between 0 and 100
    private var amountOfMatches = "10"
    var matchesIdList: [String] = []
    
    @Published var matches: [MatchDTO] = []
    
    init(summoner: SummonerDTO, region: String) {
        self.summoner = summoner
        self.region = region
    }
    
    func fetchData() {
        DispatchQueue.main.async {
            Match_v4().getMatchesArray(region: self.region, puuid: self.summoner.puuid, amount: self.amountOfMatches){ result in
                switch result {
                    case .success(let matches):
                        self.matchesIdList = matches
                        self.fetchDataMatch()
                    case .failure(let error):
                        print("Error: \(error)")
                }
            }
        }
    }
    
    private func fetchDataMatch() {
        DispatchQueue.main.async {
            var matchesList: [MatchDTO] = []
            self.matchesIdList.forEach() { matchId in
                Match_v4().getMatch(region: self.region, matchId: matchId) { result in
                    switch result {
                        case .success(let match):
                        matchesList.append(match)
                        self.matches = matchesList
                        case .failure(let error):
                            print("Error: \(error)")
                    }
                }
            }
        }
    }
    
    func getKills(match: MatchDTO) -> String {
        if(match.info.participants.contains(where: {$0.summonerId == summoner.id})) {
            if let foo = match.info.participants.first(where: {$0.summonerId == summoner.id}) {
                return String(foo.kills)
            }
        }
        return "Not Found"
    }
    
    func getDeaths(match: MatchDTO) -> String {
        if(match.info.participants.contains(where: {$0.summonerId == summoner.id})) {
            if let foo = match.info.participants.first(where: {$0.summonerId == summoner.id}) {
                return String(foo.deaths)
            }
        }
        return "Not Found"
    }
}
