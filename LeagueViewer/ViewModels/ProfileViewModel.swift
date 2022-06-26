//
//  ProfileViewModel.swift
//  LeagueViewer
//
//  Created by Student on 16.06.22.
//

import Foundation

final class ProfileViewModel : ObservableObject {
    var summoner: SummonerDTO = SummonerDTO()
    var region = ""
    var profileData: [LeagueEntryDTO] = []
    
    init(summoner: SummonerDTO, region: String) {
        self.summoner = summoner
        self.region = region
    }
    
    func fetchData() {
        DispatchQueue.main.async {
            League_v4().getProfile(region: self.region, summonerId: self.summoner.id) { result in
                switch result {
                    case .success(let profile):
                        self.profileData = profile
                    case .failure(let error):
                        print("Error: \(error)")
                }
            }
        }
    }
}
