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
    @BlackbirdLiveModels({db in
        try await CurrentMood.read(from: db)
    }) var currentMoods
    // the item currently being added
    @State var newItemDescription: String = ""
    
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
                        //                        let lastId = currentMoods.last!.id
                        //                        let newId = lastId + 1
                        //                        let newCurrentMood = CurrentMood(id: newId,
                        //                                                         description: newItemDescription,
                        //                                                         completed: false)
                        //
                        //                        currentMoods.append(newCurrentMood)
                        //                        newItemDescription = ""
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                    
                }
                .padding(20)
                
                //List
          
                
                List(currentMoods.results){currentMood in

                        HStack{
                            Text(currentMood.emoji)
                            Text(currentMood.description)
                        }

                }
                
                
            }
            .navigationTitle("Mood Mapper")
            .padding()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
