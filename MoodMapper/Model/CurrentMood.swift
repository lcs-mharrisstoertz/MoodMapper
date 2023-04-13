//
//  CurrentMood.swift
//  MoodMapper
//
//  Created by Morgan Harris-Stoertz on 2023-04-05.
//

import Blackbird
import Foundation

struct CurrentMood: BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var description: String
    @BlackbirdColumn var emoji: String
}

//struct CurrentMood: Identifiable{
//    var id: Int
//    var description: String
//    var completed: Bool
//}
//
//var existingCurrentMood = [
//    CurrentMood(id: 1, description: "Angry", completed: false),
//    CurrentMood(id: 2, description: "Happy",  completed: true),
//    CurrentMood(id: 3, description: "Sad", completed: false),
//]
