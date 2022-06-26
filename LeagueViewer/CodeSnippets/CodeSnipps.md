#  Copy paste stuff
Part of the find user data
--------------------------------

        VStack(alignment: .leading) {
            TextField("Enter Summoner Name", text: $viewModel.summonerName)
            Button(action: {}) {
                Text("Submit")
            }
        }
        .padding(.horizontal)
        
Example how to fetch array data: 
--------------------------------
struct SummonerJSON: Hashable, Codable {
    let id: String
    let accountID: String
    let puuid: String
    let name: String
    let profileIconID: Int
    let revisionDate: Int
    let summonerLevel: Int
}

final class Summoner_v4 {
    @Published var summoner: [SummonerJSON] = []
    
    func fetch(region: String, summonerName: String) {
        //URL where data should be fetched from
        guard let url = URL(string: URLBuilder().Summoner_v4(region: region, summonerName: summonerName)) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            //Convert to JSON
            do {
                let summonerData = try JSONDecoder().decode([SummonerJSON].self, from: data)
                DispatchQueue.main.async {
                    self?.summoner = summonerData
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}

// Scroll View with refresh control
/*struct RefreshableScrollView<Content: View>: UIViewRepresentable {
    var content: Content
    var onRefresh: (UIRefreshControl) -> ()
    var refreshControl = UIRefreshControl()
    
    //View Builder to capture SwiftUI View
    init(@ViewBuilder content: @escaping () -> Content, onRefresh: @escaping (UIRefreshControl) -> ()){
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> some UIScrollView {
        
        let uiscrollView = UIScrollView()
        
        //Refresh Control
        refreshControl.attributedTitle = NSAttributedString(string: "Pull")
        refreshControl.tintColor = .blue
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.onRefresh), for: .valueChanged)
        
        setUpView(uiscrollView: uiscrollView)
        
        uiscrollView.refreshControl = refreshControl
        
        return uiscrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        setUpView(uiscrollView: uiView)
    }
    
    func setUpView(uiscrollView: UIScrollView) {
        
        //Extracting SwiftUI View
        let hostView = UIHostingController(rootView: content)
        //remove need for width height calc
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        //Cliping the swiftUI view to UIKit view
        let constraints = [
            
            // Four Corners
            hostView.view.topAnchor.constraint(equalTo: uiscrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: uiscrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: uiscrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: uiscrollView.trailingAnchor),
            
            // Size
            hostView.view.widthAnchor.constraint(equalTo: uiscrollView.widthAnchor),
            hostView.view.heightAnchor.constraint(equalTo: uiscrollView.heightAnchor),
        ]
        uiscrollView.subviews.last?.removeFromSuperview()
        uiscrollView.addSubview(hostView.view)
        uiscrollView.addConstraints(constraints)
    }
    
    class Coordinator: NSObject {
        var parent: RefreshableScrollView
        
        init(parent: RefreshableScrollView) {
            self.parent = parent
        }
        
        @objc func onRefresh() {
            parent.onRefresh(parent.refreshControl)
        }
    }
}

struct MatchesView_Preview: PreviewProvider {
    static var previews: some View {
        MatchesView().environmentObject(MatchesViewModel(summoner: SummonerDTO(), region: ""))
    }
}
*/


