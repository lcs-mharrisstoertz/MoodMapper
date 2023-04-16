//
//  ListMoodsView.swift
//  MoodMapper
//
//  Created by Morgan Harris-Stoertz on 2023-04-16.
//

import Blackbird
import SwiftUI

struct ListMoodsView: View {
    
    //MARK: stored properties
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @BlackbirdLiveModels({db in
        try await CurrentMood.read(from: db,
                                   sqlWhere: "description LIKE ?", "%\(searchText)%")
    }) var currentMoods
    
    //MARK: computed properties
    var body: some View {
        List{
            ForEach(currentMoods.results){currentMood in
                
                HStack{
                    Text(currentMood.emoji)
                    Text(currentMood.description)
                }
            }
            
            .onDelete(perform: removeRows)
        }
    }
    //MARK: functions
    func removeRows(at offsets: IndexSet) {
        Task{
            try await db!.transaction { core in
                //get id of item to be deleted
                var idList = ""
                for offset in offsets {
                    idList += "\(currentMoods.results[offset].id),"
                }
                
                //Remove the final comma
                print(idList)
                idList.removeLast()
                print(idList)
                
                //delete rows from database
                try core.query("DELETE FROM CurrentMood WHERE id in (?)", idList)
            }
        }
   }
    
}

struct ListMoodsView_Previews: PreviewProvider {
    static var previews: some View {
        ListMoodsView()
    }
}
