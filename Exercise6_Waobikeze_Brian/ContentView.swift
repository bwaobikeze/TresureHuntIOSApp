//
//  ContentView.swift
//  Exercise6_Waobikeze_Brian
//
//  Created by brian waobikeze on 10/14/23.
//

import SwiftUI

struct ContentView: View {
    @State private var Teasures = [TeasureLocation]()
    var body: some View {
        NavigationView{
            List(Teasures, id: \.id){ treasures in
                NavigationLink(destination: DetailContentView( Hint: treasures.hint, capLat: treasures.cap_lat, capLong: treasures.cap_long)){
                VStack{
                    Text("\(treasures.type) # \(treasures.id)").font(.title2)
                    Text(treasures.owner).font(.title2)
                }.frame(maxWidth: .infinity, alignment: .center).background(Color(treasureColor(value: treasures.value)))
            }
                
            }
            .task {
                await loadData()
            }
        }
    }
    func treasureColor(value: Int) -> Color {
        let scaledValue = Double(value - 45) / Double(100 - 45)
        let red = scaledValue * (255.0 - 255.0) + 255.0
        let green = 215.0 + scaledValue * (255.0 - 215.0)
        let blue = 0.0
        return Color(red: red / 255, green: green / 255, blue: blue / 255)
    }
    func loadData() async {
        guard let url = URL(string: "https://m.cpl.uh.edu/courses/ubicomp/fall2022/webservice/treasures.json") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([TeasureLocation].self, from: data)
            Teasures=decodedResponse
        } catch {
            print("Error trying to decode JSON object: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
