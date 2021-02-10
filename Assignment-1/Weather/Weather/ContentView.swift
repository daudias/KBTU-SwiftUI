//
//  ContentView.swift
//  Weather
//
//  Created by Dias on 2/10/21.
//

import SwiftUI

struct ContentView: View {
    let data = [
        ["TUE", "cloud.sun.fill", "79°"],
        ["WED", "cloud.sun.rain.fill", "74°"],
        ["THU", "wind", "70°"],
        ["FRI", "wind.snow", "70°"],
        ["SAT", "cloud.sun.fill", "76°"]
    ]
    
    @State private var isNightTime = false
    
    var body: some View {
        ZStack {
            isNightTime ? Color.black.ignoresSafeArea() : Color.blue.ignoresSafeArea()
            VStack {
                Text("Cupertino, CA")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .padding()
                Image(systemName: isNightTime ? "moon.stars.fill" : "cloud.sun.fill")
                    .renderingMode(.original)
                    .font(.system(size: 150))
                    .frame(height: 150)
                    .padding()
                Text("89°")
                    .foregroundColor(.white)
                    .font(.system(size: 80))
                    .padding()
                HStack {
                    ForEach(data, id: \.self) { item in
                        VStack(spacing: 0) {
                            Text(item[0])
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            Image(systemName: item[1])
                                .renderingMode(.original)
                                .frame(width: 50, height: 50)
                                .font(.largeTitle)
                            Text(item[2])
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                        }.padding(5)
                    }
                }
                Spacer()
                Button(action: {
                    isNightTime = !isNightTime
                }) {
                    Text("Change day time")
                        .foregroundColor(.blue)
                        .font(.system(size: 25))
                        .bold()
                }.frame(maxWidth: .infinity)
                .padding(.vertical, 13)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 45)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
