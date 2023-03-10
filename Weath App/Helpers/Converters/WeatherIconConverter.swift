//
//  WeatherIconConverter.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 10/3/23.
//

import SwiftUI

func convertWeatherIconFromId(_ id: String) -> Image {
    switch id {
    case "01d":
        return Image(uiImage: Resources.Images.Weather.sun)
    case "01n":
        return Image(uiImage: Resources.Images.Weather.moon)
    case "02d":
        return Image(uiImage: Resources.Images.Weather.cloudSun)
    case "02n":
        return Image(uiImage: Resources.Images.Weather.cloudMoon)
    case "03d", "03n", "04d", "04n":
        return Image(uiImage: Resources.Images.Weather.cloud)
    case "09d", "09n", "10d", "10n":
        return Image(uiImage: Resources.Images.Weather.cloudSunRain)
    case "11d", "11n":
        return Image(uiImage: Resources.Images.Weather.cloudSunBolt)
    case "13d", "13n":
        return Image(uiImage: Resources.Images.Weather.cloudSnow)
    case "50d", "50n":
        return Image(uiImage: Resources.Images.Weather.wind)
    default:
        return Image(systemName: "questionmark.circle")
    }
}
