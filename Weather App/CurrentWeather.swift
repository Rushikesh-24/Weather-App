//
//  ContentView.swift
//  Weather App
//
//  Created by Rushikesh Gaonkar on 09/03/24.
//

import SwiftUI

struct CurrentWeather: View {
    @ObservedObject var viewModel =  WeatherViewModel()
    @State private var isNight = false
    @State private var cityName: String = "Mumbai"
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
        VStack{
            if let weather = viewModel.weather{
                TextField("City Name",text: $cityName)
                    .font(.system(size: 36,weight: .medium,design: .default))
                    .foregroundStyle(.white)
                    .padding()
                    .position(x:300,y:100)
                    .onSubmit {
                        print("hello")
                            Task{
                                await viewModel.getWeather(city: cityName)
                            }
                    }
//                CityTextView(cityName: "\(weather.location?.name ?? "")")
                CurrentStatus(temp: weather.current?.tempC ?? 0, icon:isNight ? "moon.stars.fill" : "cloud.sun.fill")
                .padding(.bottom,130)
                HStack(spacing:20){
                    WeatherDayView(dayOfWeek: "MON", imageName: "cloud.sun.fill", temperature: Int(weather.forecast?.forecastday?[0].day?.avgtempC ?? 0))
                        WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: Int(weather.forecast?.forecastday?[1].day?.avgtempC ?? 0))
                        WeatherDayView(dayOfWeek: "THUR", imageName: "cloud.sun.fill", temperature: Int(weather.forecast?.forecastday?[2].day?.avgtempC ?? 0))
                        WeatherDayView(dayOfWeek: "FRI", imageName: "sun.max.fill", temperature: Int(weather.forecast?.forecastday?[3].day?.avgtempC ?? 0))
                        WeatherDayView(dayOfWeek: "SAT", imageName: "cloud.sun.fill", temperature: Int(weather.forecast?.forecastday?[4].day?.avgtempC ?? 0))
                }
                    Spacer()
                Button{
                    isNight.toggle()
                }label: {
                    MyButton(text: "Change Day Time",color: .white, textColor : .blue)
                }
                Spacer()
               }
               else{
                Text("Loading...")
              }
           }
        }
        .task {
           await viewModel.getWeather(city: cityName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeather()
    }
}


struct WeatherDayView: View {
    var dayOfWeek : String
    var imageName: String
    var temperature:Int
    var body: some View {
        VStack{
            Text(dayOfWeek)
                .font(.system(size: 25,weight: .medium))
                .foregroundStyle(.white)
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50,height: 50)
            Text("\(temperature)°")
                .font(.system(size: 30,weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

struct BackgroundView: View {
    var isNight:Bool
    var body: some View {
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    var cityName :String
    var body: some View {
        Text(cityName)
            .font(.system(size: 32,weight: .medium,design: .default))
            .foregroundStyle(.white)
            .padding()
    }
}

struct CurrentStatus: View {
    var temp:Int
    var icon:String
    var body: some View {
        VStack(spacing:6){
            Image(systemName: icon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180,height: 180)
            Text("\(temp)°")
                .font(.system(size: 70,weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

struct MyButton: View {
    var text:String
    var color:Color
    var textColor:Color
    var body: some View {
            Text(text)
                .frame(width: 280,height: 50)
                .background(color.gradient)
                .foregroundColor(textColor)
                .font(.system(size: 20,weight: .bold,design: .default))
                .clipShape(RoundedRectangle(cornerRadius: 20), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
        }
}
