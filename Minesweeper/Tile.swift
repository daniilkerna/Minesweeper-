//
//  Tile.swift
//  Minesweeper
//
//  Created by Alberto Clara and Daniil Kerna
//  Copyright © 2018 Alberto Clara and Daniil Kerna. All rights reserved.
//

import Foundation

class Tile {
    let row:Int
    let col:Int
    
    var numNeighboringMines = 0
    var isMineLocation = false
    var isRevealed = false
    var isFlagged = false
    
    init(row:Int, col:Int) {
        self.row = row
        self.col = col
    }
    
}
