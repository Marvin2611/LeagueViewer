//
//  ChampionsViewModel.swift
//  LeagueViewer
//
//  Created by Student on 25.06.22.
//

import Foundation

final class ChampionsViewModel : ObservableObject {
    var summoner: SummonerDTO = SummonerDTO()
    var region = ""
    
    @Published var champions: [ChampionMasterDTO] = []
    
    init(summoner: SummonerDTO, region: String) {
        self.summoner = summoner
        self.region = region
    }
    
    func fetchData(){
        DispatchQueue.main.async {
            var championsList: [ChampionMasterDTO] = []
            Champion_Mastery_v4().getChampions(region: self.region, summonerId: self.summoner.id){ result in
                switch result {
                    case .success(let champions):
                        championsList = champions
                        self.champions = championsList
                    case .failure(let error):
                        print("Error: \(error)")
                }
            }
        }
    }
}
