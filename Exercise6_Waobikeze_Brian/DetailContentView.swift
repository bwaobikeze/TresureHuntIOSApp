//
//  DetailContentView.swift
//  Exercise6_Waobikeze_Brian
//
//  Created by brian waobikeze on 10/14/23.
//

import SwiftUI
import MapKit



struct DetailContentView: View {
    @State var Hint:String
    @State var capLat:Double
    @State var capLong: Double
    init(Hint: String, capLat: Double, capLong: Double) {
        self.Hint = Hint
        self.capLat = capLat
        self.capLong = capLong
    }
    var body: some View {
        Map{Marker(coordinate: CLLocationCoordinate2D(latitude: capLat, longitude: capLong)){
            VStack{
                Text(Hint)
                    .font(.headline)
                Spacer()
                Text("Administrative Area: \(administrativeArea)")
                Text("Locality: \(locality)")
                Text("ISO Country Code: \(isoCountryCode)")
            }
        }}.onAppear {
            self.updateMapDetails()
        }
    }
    @State private var administrativeArea = ""
    @State private var locality = ""
    @State private var isoCountryCode = ""
    func updateMapDetails() {
        let location = CLLocation(latitude: capLat, longitude: capLong)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error)")
            } else if let placemark = placemarks?.first {
                administrativeArea = placemark.administrativeArea ?? ""
                locality = placemark.locality ?? ""
                isoCountryCode = placemark.isoCountryCode ?? ""
            }
        }
    }
}

#Preview {
    DetailContentView(Hint: "", capLat: 0.0, capLong: 0.0)
}
