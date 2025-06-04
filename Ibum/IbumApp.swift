//
//  IbumApp.swift
//  Ibum
//
//  Created by tanaka niko on 2025/05/30.
//

import SwiftUI
import SwiftData

@main
struct IbumApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: [Quest.self,Photo.self])
    }
        
    
}

func seedInitialDataIfNeeded(modelContext: ModelContext) async {
    let fetchDescriptor = FetchDescriptor<Quest>()
    
    // すでにデータがあれば何もしない
    if let count = try? modelContext.fetchCount(fetchDescriptor), count > 0 {
        return
    }
    
    let items = [
        Quest(title: "笑顔でピース", phots: [], tags: [.kantan,.genki], favorite: false, clear: false),
        Quest(title: "自信のかたまり", phots: [], tags: [.cool,.zensin], favorite: false, clear: false),
        Quest(title: "横顔", phots: [], tags: [.cool,.kao], favorite: false, clear: false),
        Quest(title: "風になびく", phots: [], tags: [.cool], favorite: false, clear: false),
        Quest(title: "お願いの姿勢", phots: [], tags: [.kantan,.zensin], favorite: false, clear: false)
    ]

    for item in items {
        modelContext.insert(item)
    }

    try? modelContext.save()
}

