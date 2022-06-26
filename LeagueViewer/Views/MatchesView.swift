//
//  MatchesView.swift
//  LeagueViewer
//
//  Created by Student on 25.06.22.
//

import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var viewModel: MatchesViewModel
    
    var body: some View {
        NavigationView {
            //Start of view content
            List(viewModel.matches, id: \.id) { match in
                VStack(alignment: .leading, spacing: 5) {
                    Text("Match ID: " + match.metadata.matchId)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text("Match Playtime: " + returnTimeMinutes(timeInterval: match.info.gameDuration))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    HStack() {
                        Text("Kills: " + viewModel.getKills(match: match))
                        Text("Deaths: " + viewModel.getDeaths(match: match))
                    }
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
            //End of view content
            .navigationBarTitle("Your Matches")
        }
        .tabItem {
            VStack {
                Text("Matches")
            }
        }
    }
}
