//
//  Lists.swift
//  Alias Word Game
//
//  Created by Alex Khmurovich on 12/30/24.
//

import Foundation

class Lists{
    private static var adjectives = [
        "Brave", "Bold", "Mighty", "Swift", "Clever", "Fierce", "Wise", "Vigorous", "Noble", "Powerful",
        "Fearless", "Loyal", "Resilient", "Valiant", "Daring", "Proud", "Steady", "Royal", "Vigorous",
        "Glorious", "Majestic", "Radiant", "Sharp", "Dynamic", "Stalwart", "Tenacious", "Graceful",
        "Enduring", "Fierce", "Energetic", "Harmonious", "Courageous", "Intrepid", "Swift", "Bold",
        "Mighty", "Stealthy", "Heroic", "Invincible", "Relentless", "Gallant", "Fearless", "Vibrant",
        "Radiant", "Savage", "Mighty", "Strategic", "Epic", "Incredible", "Defiant", "Vicious",
        "Zealous", "Spirited", "Determined", "Cunning", "Swift", "Unyielding", "Diligent", "Majestic"
    ]
    
    init(){
        Lists.adjectives.shuffle()
    }
}
