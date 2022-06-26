//
//  LoginViewModel.swift
//  LeagueViewer
//
//  Created by Student on 16.06.22.
//

import Foundation

final class LoginViewModel : ObservableObject {
    @Published var summonerName = ""
    @Published var summonerRegion = "NA"
    
    @Published var summonerNameSuccess = false
    @Published var summoner: SummonerDTO = SummonerDTO()
    @Published var region = ""
    @Published var showingAlert = false

    func Submit(){
        //Here should be checked, whether the user exists or not
        //If he does, request data and send to StartView
        var nameValid = false
        
        DispatchQueue.main.async {
            Summoner_v4().getSummoner(region: self.regionCheck1(), summonerName: self.summonerName.lowercased()) { result in
                switch result {
                    case .success(let summoner):
                        self.summoner = summoner
                        nameValid = true
                    case .failure(let error):
                        print("Error: \(error)")
                        nameValid = false
                }
            }
            if(nameValid) {
                self.region = self.regionCheck1()
                self.summonerNameSuccess.toggle()
            }
            else {
                self.showingAlert.toggle()
            }
        }
    }
    
    func regionCheck1() -> String {
        if(summonerRegion == "KR" || summonerRegion == "RU") {
            return summonerRegion.lowercased()
        }
        else {
            return summonerRegion.lowercased().appending("1")
        }
    }
}
