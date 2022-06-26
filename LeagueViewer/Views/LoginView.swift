//
//  LoginView.swift
//  LeagueViewer
//
//  Created by Student on 16.06.22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    @Binding var summonerNameSuccess: Bool
    @Binding var summoner: SummonerDTO
    @Binding var region: String
    
    @State private var summonerRegionSelection = "NA"
    let summonerRegions = [
        "NA", "EUW", "EUN", "KR", "BR", "JP", "RU", "OCE", "TR", "LAN", "LAS"
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Enter Summoner Name", text: $viewModel.summonerName)
                Picker("Region", selection:
                    $viewModel.summonerRegion) {
                    ForEach(summonerRegions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
            }
            Button(action: {
                viewModel.Submit()
            }) {
                Text("Submit")
            }
            .onChange(of: viewModel.summonerNameSuccess == true) { tmp in summoner = viewModel.summoner
                region = viewModel.region
                summonerNameSuccess.toggle()
            }
            .alert("User not found", isPresented: $viewModel.showingAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        .padding(.horizontal)
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var summoner = SummonerDTO()
    @State static var region = ""
    
    static var previews: some View {
        LoginView(summonerNameSuccess: .constant(false), summoner: $summoner, region: $region).environmentObject(LoginViewModel())
    }
}
