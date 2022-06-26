//
//  StartViewModel.swift
//  LeagueViewer
//
//  Created by Student on 16.06.22.
//

import Foundation

final class StartViewModel : ObservableObject {
    var summoner: SummonerDTO = SummonerDTO()
    var region = ""
    
    init(summoner: SummonerDTO, region: String) {
        self.summoner = summoner
        self.region = region
    }
}
