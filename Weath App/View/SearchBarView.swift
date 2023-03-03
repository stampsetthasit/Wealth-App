//
//  SearchBar.swift
//  Weath App
//
//  Created by Yadar Tulayathamrong on 2/3/2566 BE.
//

import SwiftUI

struct SearchBarView: View {
    @State var searchText : String = ""
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.gray : Color.purple
                )
            
            TextField("Search your location...", text: $searchText)
                .foregroundColor(Color.black)
            
            Image(systemName: "location.circle.fill")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color(.systemGray) : Color.purple )
            
        }.padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray5))
                    
            )
            .padding()
    }
}

struct SearchBarCView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
