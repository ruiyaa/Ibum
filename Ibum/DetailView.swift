//
//  detailView.swift
//  Ibum
//
//  Created by tanaka niko on 2025/06/06.
//

import SwiftUI
import _SwiftData_SwiftUI

struct DetailView: View {
//    @State var position:CGPoint
    @State var scale:CGFloat = 1
    @State var width = UIScreen.main.bounds.width / 4 * 3
    @Binding var photo:Photo
    @Query private var quests: [Quest]
    
    var body: some View {
        ZStack{
                Color.yellow
                    .frame(height: UIScreen.main.bounds.height / 2)
                    .position(CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 4 * 3))
                    .ignoresSafeArea()

            VStack{
                Spacer()
                Text(photo.questTitle)
                    .font(.largeTitle)
                Image(uiImage: UIImage(data: photo.photoData)!)
                    .resizable()
                    .scaleEffect(scale)
                    .frame(width: width)
                    .clipShape(Circle())
                    .padding(.bottom, 50)
                    .overlay() {
                          Circle()
                            .stroke(.yellow, lineWidth: 10)
                            .frame(width: width)
                            .padding(.bottom, 50)
                            
                        }
                Grid {
                    GridRow {
                        Image(systemName: "globe")
                        Image(systemName: "globe")
                        Image(systemName: "globe")
                        Image(systemName: "globe")
                    }
                    GridRow {
                        Image(systemName: "globe")
                        Image(systemName: "globe")
                        Image(systemName: "globe")
                        Image(systemName: "globe")
                        
                    }
                }
                HStack{
                    
                    Button(action:{
                        
                    }){
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                            .padding()
                    }
                  Spacer()
                    Button(action: {
                        
                    }){
                        Image(systemName:"square.and.arrow.down")
                            .padding()
                        
                    }
                
                }
            }
        }
        
        
    }
}

//#Preview {
//    DetailView(position: CGPoint(x: 500, y: 500))
//}
