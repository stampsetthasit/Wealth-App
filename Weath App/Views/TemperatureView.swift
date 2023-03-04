//
//  TemperatureView.swift
//  Weath App
//
//  Created by Yadar Tulayathamrong on 2/3/2566 BE.
//

import SwiftUI

struct TemperatureView: View {
    var body: some View {
        VStack{
            Text("Temperature")
                .font(.system(size:22, weight: .bold, design: .rounded))
            ScrollView(.horizontal, showsIndicators: false){
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                        Color("Purpil")
                        )
                        .shadow(
                            color: Color.gray.opacity(10) ,
                            radius: 5,x:0,y:5)
                        .frame(width: 62 , height: 88)
                    
                    Text("29*C")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                    
                }
                    .padding()
            }
        }.padding()
          
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView()
    }
}

