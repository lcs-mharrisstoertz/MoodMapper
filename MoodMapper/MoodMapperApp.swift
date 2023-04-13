//
//  MoodMapperApp.swift
//  MoodMapper
//
//  Created by Morgan Harris-Stoertz on 2023-04-05.
//
import Blackbird
import SwiftUI

@main
struct MoodMapperApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
