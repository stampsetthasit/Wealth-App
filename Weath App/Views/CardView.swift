//
//  CardView.swift
//  Weath App
//
//  Created by Yadar Tulayathamrong on 2/3/2566 BE.
//

import SwiftUI

struct CardView: View {
    var body: some View {
       RoundedRectangle(cornerRadius: 30)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color("Purpil"),Color("Yelliw")]),
                    startPoint: .top,
                    endPoint: .bottom)
            )
            .shadow(
                color: Color.gray.opacity(10) ,
                radius: 5,x:0,y:5)

            .frame(width: 335 , height: 215)
            .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
