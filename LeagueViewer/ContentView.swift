//
//  ContentView.swift
//  LeagueViewer
//
//  Created by Student on 16.06.22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : ContentViewModel
    @State var summonerNameSuccess = false
    @State var summoner = SummonerDTO()
    @State var region = ""
    
    var body: some View {
        return Group {
            if summonerNameSuccess {
                StartView().environmentObject(StartViewModel(summoner: summoner, region: region))
            }
            else {
                LoginView(summonerNameSuccess: $summonerNameSuccess, summoner: $summoner, region: $region).environmentObject(LoginViewModel())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var summoner = SummonerDTO()
    
    static var previews: some View {
        ContentView(summoner: summoner).environmentObject(ContentViewModel())
    }
}
