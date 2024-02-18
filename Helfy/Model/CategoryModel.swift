//
//  CategoryModel.swift
//  Helfy
//
//  Created by 윤성은 on 2/18/24.
//

import Foundation

// MARK: - Welcome
struct CategoryModel: Codable {
    let flood, volcanicEruption, landslide, typhoon: String
    let heavySnow, lightning, strongWind, yellowDust: String
    let drought, spacePropagationDisaster, tidalWave, theFallOfNaturalSpaceObjects: String
    let heavyRain, flooding, heatWave, greenTide: String
    let coldWave, tsunami, risingSeaLevel, earthquake: String
    let windAndWaves, redTide: String

    enum CodingKeys: String, CodingKey {
        case flood = "FLOOD"
        case volcanicEruption = "VOLCANIC_ERUPTION"
        case landslide = "LANDSLIDE"
        case typhoon = "TYPHOON"
        case heavySnow = "HEAVY_SNOW"
        case lightning = "LIGHTNING"
        case strongWind = "STRONG_WIND"
        case yellowDust = "YELLOW_DUST"
        case drought = "DROUGHT"
        case spacePropagationDisaster = "SPACE_PROPAGATION_DISASTER"
        case tidalWave = "TIDAL_WAVE"
        case theFallOfNaturalSpaceObjects = "THE_FALL_OF_NATURAL_SPACE_OBJECTS"
        case heavyRain = "HEAVY_RAIN"
        case flooding = "FLOODING"
        case heatWave = "HEAT_WAVE"
        case greenTide = "GREEN_TIDE"
        case coldWave = "COLD_WAVE"
        case tsunami = "TSUNAMI"
        case risingSeaLevel = "RISING_SEA_LEVEL"
        case earthquake = "EARTHQUAKE"
        case windAndWaves = "WIND_AND_WAVES"
        case redTide = "RED_TIDE"
    }
}
