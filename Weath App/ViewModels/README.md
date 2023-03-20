# Current Weather Example Usage
```swift
struct CurrentExample: View {
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        ScrollView {
            VStack {                
                Text(weatherVM.cityName)
                    .font(.title)
                    .padding()
                
                Text(weatherVM.temp)
                    .font(.system(size: 80))
                    .fontWeight(.thin)
                
                Text(weatherVM.descript)
                    .font(.title2)
                    .padding()
                
                Text("Feels like \(weatherVM.feelsLike)")
                
                Text("Wind speed: \(weatherVM.windSpeed)")
                
                Text("Humidity: \(weatherVM.humidity)")
                
                Text("Sunrise time: \(weatherVM.sunriseTime)")
                
                Text("Sunset time: \(weatherVM.sunsetTime)")
                
                Text("Visibillity: \(weatherVM.visibility)")
                
                Text("Date: \(weatherVM.date)")
            }
        }
    }
}
```

# Forecast Weather Example Usage
```swift
struct ForecastExample: View {

    @ObservedObject var forecastVM: WeatherViewModel

    let mockup = [
        ForeList(dt: 1678611600, main: MainClass(temp: 26.88, feelsLike: 25.88, tempMin: 26.88, tempMax: 26.88, pressure: 1014, seaLevel: 1014, grndLevel: 899, humidity: 15), weather: [Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")], clouds: Clouds(all: 100), wind: Wind(speed: 5.18, deg: 206, gust: 5.21), visibility: 10000, pop: 0.0, dtTxt: "2023-03-12 09:00:00"),
    ]

    var body: some View {
        List {
            ForEach((forecastVM.forecastModel?.list ?? mockup), id: \.dtTxt) { item in
                VStack(alignment: .leading) {
                    Text(item.dtTxt)
                        .font(.headline)
                    HStack {
                        Text("Temperature:")
                        Spacer()
                        Text("\(Int(item.main.tempMax ?? 0))°C / \(Int(item.main.tempMin ?? 0))°C")
                    }
                    HStack {
                        Text("Description:")
                        Spacer()
                        Text(item.weather.first?.description.capitalized ?? "")
                    }
                    HStack {
                        Text("Humidity:")
                        Spacer()
                        Text("\(item.main.humidity ?? 0)%")
                    }
                    HStack {
                        Text("Wind:")
                        Spacer()
                        Text("\(Int(item.wind.speed)) km/h")
                    }
                }
            }
        }
        
    }
}
```
