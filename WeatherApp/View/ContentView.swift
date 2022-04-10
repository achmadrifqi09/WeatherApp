//
//  ContentView.swift
//  WeatherApp
//
//  Created by Achmad Rifqi on 09/04/22.
//

import SwiftUI

struct ContentView: View {
    @State var isActive = false
    @State var size  = 0.9
    @State var opacity = 0.5
    
    var body: some View {
        if isActive{
            HomeView()
        }else{
            ZStack{
                Color("bgColor").ignoresSafeArea()
                VStack{
                    Image(systemName: "cloud.moon.rain")
                        .resizable()
                        .foregroundColor(Color("logoColor"))
                        .frame(width : 90, height: 90)
                    Text("Weather App")
                        .font(.headline)
                        .foregroundColor(Color("logoColor"))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1)){
                        self.size = 1
                        self.opacity = 1
                    }
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline : .now() + 3.0){
                        self.isActive = true
                    }
                }
            
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
