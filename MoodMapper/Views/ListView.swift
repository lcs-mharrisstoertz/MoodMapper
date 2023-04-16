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
                
              
                .searchable(text: $searchText)
             
            }
            .navigationTitle("Mood Mapper")
            .padding()
        }
        
    }
    
   
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
