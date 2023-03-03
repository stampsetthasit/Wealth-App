//
//  ContentView.swift
//  Weath App
//
//  Created by Yadar Tulayathamrong on 2/3/2566 BE.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ScrollView{
            VStack{
               SearchBarView()
                CardView()
                TemperatureView()
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
