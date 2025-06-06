//
//  detailView.swift
//  Ibum
//
//  Created by tanaka niko on 2025/06/06.
//

import SwiftUI

struct DetailView: View {
    @State var position:CGPoint
    @State var scale:CGFloat = 1
    @State var width = UIScreen.main.bounds.width / 4 * 3
    
    var body: some View {
        ZStack{
                Color.yellow
                    .frame(height: UIScreen.main.bounds.height / 2)
                    .position(CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 4 * 3))
                    .ignoresSafeArea()

            VStack{
                Spacer()
                Text("タイトルを入力")
                    .font(.largeTitle)
                Color.cyan
    //                .resizable()
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

#Preview {
    DetailView(position: CGPoint(x: 500, y: 500))
}
