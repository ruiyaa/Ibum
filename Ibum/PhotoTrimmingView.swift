import SwiftUI

//class trimmingViewController:UIViewController{
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}

struct PhotoTrimmingView: View {
    @State private var scale: CGFloat = 1.01
    @State var position: CGSize = CGSize(width: 200, height: 300)
    
    @State var image:UIImage
        
    var drag: some Gesture {
        DragGesture()
            .onChanged{ value in
                self.position = CGSize(
                    width: value.startLocation.x
                        + value.translation.width,
                    height: value.startLocation.y
                        + value.translation.height
                )
            }
            .onEnded{ value in
                self.position = CGSize(
                    width: value.startLocation.x
                        + value.translation.width,
                    height: value.startLocation.y
                        + value.translation.height
                )
            }
            
        }
    
    var pinch : some Gesture{
        MagnificationGesture()
            .onChanged { value in
                scale = value
            }
    }
    
    var body: some View {
        VStack {
            ZStack{
                Image(uiImage: image)
                    .resizable()
                    .scaleEffect(scale)
                    .frame(width:.infinity)
                    .scaledToFit()
                    .position(x: position.width, y: position.height)
                    .gesture(SimultaneousGesture(drag,pinch))
                Rectangle()
                    .fill(.black)
                    .opacity(0.7)
                    .overlay() {
                          Circle()
                            .frame(width: .infinity)
                            .blendMode(.destinationOut)
                        }
                    .compositingGroup()
                Circle()
                    .stroke(style:
                        StrokeStyle(
                        lineWidth: 5,
                        dash: [20, 20]
                    ))
                    .frame(width: .infinity)
                Color.clear
                    .contentShape(Rectangle())
                    .frame(width: .infinity,height: .infinity)
                    .gesture(SimultaneousGesture(drag,pinch))
                VStack{
                    Spacer()
                    Button(action: {
                        
                    }){
                        Text("追加")
                    }
                }
                    
            }
           
        }
    }
}

//#Preview {
//    PhotoTrimmingView()
//}
