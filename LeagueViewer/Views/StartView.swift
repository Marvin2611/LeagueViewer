//
//  StartView.swift
//  LeagueViewer
//
//  Created by Student on 16.06.22.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var viewModel : StartViewModel
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            MatchesView().environmentObject(MatchesViewModel(summoner: viewModel.summoner, region: viewModel.region)).tag(1)
            ProfileView().environmentObject(ProfileViewModel(summoner: viewModel.summoner, region: viewModel.region)).tag(0)
            ChampionsView().environmentObject(ChampionsViewModel(summoner: viewModel.summoner, region: viewModel.region)).tag(2)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(StartViewModel(summoner: SummonerDTO(), region: ""))
    }
}
