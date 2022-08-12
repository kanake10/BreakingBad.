//
//  ContentView.swift
//  BreakingBad
//
//  Created by Ezra Kanake on 12/08/2022.
//

import SwiftUI

struct URLImage: View{
    let UrlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:150 , height: 190)
                .background(Color.gray)
        }
        else{
            Image(systemName: "load")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:130 , height: 70)
                .background(Color.gray)
                .onAppear(){
                    fetchImage()
                }
        }
    }
    
    private func fetchImage(){
        guard let url = URL (string: UrlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, _, _
            in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach (viewModel.characters,id: \.self) { character in
                    HStack{
                        URLImage(UrlString: character.img)
                        
                        Text(character.name)
                            .bold()
                            .padding(3)
                    }
            }
        }
            .navigationTitle("Characters")
            .onAppear(){
                viewModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    } 
}
