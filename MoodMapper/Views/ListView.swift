//
//  ListView.swift
//  MoodMapper
//
//  Created by Morgan Harris-Stoertz on 2023-04-05.
//
import Blackbird
import SwiftUI

struct ListView: View {
    //MARK: stored properties
    //the item currently being stored
    @Environment(\.blackbirdDatabase) var db:Blackbird.Database?
    
    @BlackbirdLiveModels({db in
        try await CurrentMood.read(from: db,
                                   sqlWhere: "description LIKE ?", "%\(searchText)%")
    }) var currentMoods
    
    // the item currently being added
    @State var newItemDescription: String = ""
    @State var newEmojiDescription: String = ""
    @State var searchText = ""
    
    
    //MARK: computed properties
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("How do you feel?")
                    Spacer()
                }
                HStack{
                    TextField("Enter your current mood ...", text: $newItemDescription)
                    
                    //button
                    
                    Button(action: {
                        Task{
                            //write to the data base
                            try await db!.transaction { core in
                                try core.query("INSERT INTO CurrentMood (description, emoji) VALUES (?,?)", newItemDescription, newEmojiDescription)
                            }
                            
                        //clear the input field
                            newItemDescription = ""
                            newEmojiDescription = ""
                        }
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                    
                }
                
                
                HStack{
                    TextField("Enter an emoji ...", text: $newEmojiDescription)
                    
                 
                }
                
                
                
                
                //List
                
                List{
                    ForEach(currentMoods.results){currentMood in
                        
                        HStack{
                            Text(currentMood.emoji)
                            Text(currentMood.description)
                        }
                    }
                    
                    .onDelete(perform: removeRows)
                }
                .searchable(text: $searchText)
             
            }
            .navigationTitle("Mood Mapper")
            .padding()
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
//        for offset in offsets {
//            print(offset)
//        }
   }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
