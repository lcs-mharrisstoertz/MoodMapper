//
//  CurrentMood.swift
//  MoodMapper
//
//  Created by Morgan Harris-Stoertz on 2023-04-05.
//

import Foundation

struct CurrentMood: Identifiable{
    var id: Int
    var description: String
}

var existingTodoItems = [
CurrentMood(id: 1, description: "Angry"),
CurrentMood(id: 2, description: "Happy"),
CurrentMood(id: 3, description: "Sad"),
]
