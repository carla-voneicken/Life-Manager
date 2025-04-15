//
//  ToDoViewTest.swift
//  Life-Manager
//
//  Created by Christiane Roth on 15.04.25.
//

import SwiftUI
struct ToDoViewTest: View {
    
    var body: some View {
        VStack {
            
            HStack(){
                Spacer()
                Button(action: { }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green.opacity(0.3))
                        .font(.system(size: 30))
                    
                        .padding()
                        .frame(width: 50, height: 50)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(10)
                        .shadow(radius: 400)
                }
                Button(action: { }) {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.red.opacity(0.3))
                        .font(.system(size: 30))
                    
                        .padding()
                        .frame(width: 50, height: 50)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        }
                    }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                List {
                    Text("Urlaub")
                    Text("Kochen")
                    Text("Sport")
                    Text("Kinder")
                }
            }
           
                .padding()
                Spacer()
                
           
            }
        }
    }


#Preview {
    ToDoViewTest()
}
