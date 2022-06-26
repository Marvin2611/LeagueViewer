//
//  ChampionsView.swift
//  LeagueViewer
//
//  Created by Student on 25.06.22.
//

import SwiftUI

struct ChampionsView: View {
    @EnvironmentObject var viewModel: ChampionsViewModel
    
    var body: some View {
        NavigationView {
            //Start of view content
            List(viewModel.champions, id: \.id) { champion in
                VStack(alignment: .leading, spacing: 5) {
                    Text("Champion ID: " + String(champion.championId))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text("Playtime: " + returnTimeDate(timeInterval: champion.lastPlayTime))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text("Champion Level: " + String(champion.championLevel))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text("Champion Points: " + String(champion.championPoints))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text("Points for next Level: " + String(champion.championPointsUntilNextLevel))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text("Chest granted: " + String(champion.chestGranted))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
            //End of view content
            .navigationBarTitle("Your Champions")
        }
        .tabItem {
            VStack {
                Text("Champions")
            }
        }
    }
}

struct ChampionsView_Preview: PreviewProvider {
    static var previews: some View {
        ChampionsView().environmentObject(ChampionsViewModel(summoner: SummonerDTO(), region: ""))
    }
}
