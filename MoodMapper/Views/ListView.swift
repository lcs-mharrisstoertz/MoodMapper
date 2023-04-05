//
//  ListView.swift
//  MoodMapper
//
//  Created by Morgan Harris-Stoertz on 2023-04-05.
//

import SwiftUI

struct ListView: View {
    //MARK: stored properties
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
                        Task{
                            //task to be filled in ..
                            
                        //clear the input field
                            newItemDescription = ""
                        }
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                    
                }
                .padding(20)
                
                //List
                
                List{
                    HStack{
                       
                        Text("Happy")
                    }
                    
                    HStack{
                       
                        Text("Sad")
                    }
                    
                    HStack{
                     
                        Text("Tired")
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
