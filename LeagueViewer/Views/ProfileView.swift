//
//  ProfileView.swift
//  LeagueViewer
//
//  Created by Student on 16.06.22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            //Start of view content
            List {
                Text("Summoner: " + viewModel.summoner.name)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                Text("SummonerLevel: " + String(viewModel.summoner.summonerLevel))
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                Text("Region: " + viewModel.region)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
            }
            
            //End of view content
            .navigationBarTitle("Your Profile")
        }
        .tabItem {
            VStack {
                Text("Profile")
            }
        }
        .onAppear() {
            viewModel.fetchData()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(ProfileViewModel(summoner: SummonerDTO(), region: ""))
    }
}
