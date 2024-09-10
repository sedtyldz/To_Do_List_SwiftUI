//
//  ContentView.swift
//  To-do_list
//
//  Created by Sedat Yıldız on 10.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("notes") private var notesData: Data = Data()
    @State private var notes: [String] = []
    @State private var not: String = ""

    var body: some View {
        ZStack{
            ContainerRelativeShape()
                .fill(LinearGradient(colors: [Color.white, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            
            VStack{
                Text("To do App")
                    .bold()
                    .font(.title)
                    .foregroundColor(.black)
                Spacer().frame(height: 50)
                
                TextField("Add Your Notes", text: $not)
                    .bold()
                    .padding()
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 300,height: 50,alignment:.center)
                    .background(.gray)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    

                    
                
                Spacer().frame(height: 30)
                
                Button(action: {
                    add(note: not)
                    not = ""
                }) {
                    Text("Add Note")
                        .bold()
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.cyan)
                        .cornerRadius(20)
                }
                
                Spacer()
                
                
                ScrollView {
                    VStack(spacing: 5) {
                        ForEach(Array(notes.enumerated()), id: \.offset) { index, note in
                            HStack {
                                Text(note)
                                    .bold()
                                    .padding()
                                    .font(.title2)
                                    .foregroundColor(.black)
                                Spacer()
                                
                                Button(action: {
                                    remove(at: index)
                                }) {
                                    Image(systemName:"trash")
                                        .resizable()
                                        .frame(width: 35,height: 35)
                                        .padding()
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: loadNotes)
            }
        }
        .preferredColorScheme(.light)
    }
    
    private func saveNotes() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(notes)
            notesData = data
        } catch {
            print("Failed to encode notes: \(error)")
        }
    }

    private func loadNotes() {
        do {
            let decoder = JSONDecoder()
            notes = try decoder.decode([String].self, from: notesData)
        } catch {
            print("Failed to decode notes: \(error)")
        }
    }

    private func add(note: String) {
        if !note.isEmpty {
            notes.append(note)
            saveNotes()
        }
    }
   
    private func remove(at index: Int) {
        notes.remove(at: index)
        saveNotes()
    }
}

#Preview {
    ContentView()
}
