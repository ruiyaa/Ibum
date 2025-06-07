import SwiftUI
import SwiftData
//class trimmingViewController:UIViewController{
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}

struct PhotoTrimmingView: View {
    let dismissToRoot: () -> Void
    let onDismiss: () -> Void
    
//    @Environment(\.isPresentedCamera) private var isPresentedCamera
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var context
    @Query var quests: [Quest]
    
    @State private var scale: CGFloat = 1.01
    @State var position: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    
    @State var image:UIImage
    @State var questTitle:String = ""
    
    @EnvironmentObject var shareValue: isPresenteCamera
    
    @StateObject private var isPresentedCamera = isPresenteCamera()
    
//    @Binding private var isPresentedCamera :Bool
   

        
    var drag: some Gesture {
        DragGesture()
            .onChanged{ value in
                self.position = CGPoint(
                    x: value.startLocation.x
                        + value.translation.width,
                    y: value.startLocation.y
                        + value.translation.height
                )
            }
            .onEnded{ value in
                self.position = CGPoint(
                    x: value.startLocation.x
                        + value.translation.width,
                    y: value.startLocation.y
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
        let bounds = UIScreen.main.bounds
        let width = bounds.width
        let height = bounds.height
        
        VStack {
            ZStack{
                Image(uiImage: image)
                    .resizable()
                    .scaleEffect(scale)
                    .frame(width: width)
                    .scaledToFit()
                    .position(x: position.x, y: position.y)
                    .gesture(SimultaneousGesture(drag,pinch))
                Rectangle()
                    .fill(.black)
                    .opacity(0.7)
                    .overlay() {
                          Circle()
                            .frame(width: width)
                            .blendMode(.destinationOut)
                        }
                    .compositingGroup()
                Circle()
                    .stroke(style:
                        StrokeStyle(
                        lineWidth: 5,
                        dash: [20, 20]
                    ))
                    .frame(width: width)
                Color.clear
                    .contentShape(Rectangle())
                    .frame(width: width,height: height)
                    .gesture(SimultaneousGesture(drag,pinch))
                VStack{
                    Spacer()
                    Button(action: {
                        add()
                    }){
                        Text("追加")
                    }
                    Spacer()
                }
                    
            }
           
        }
        .onAppear{
            isPresentedCamera.isOn = false
            do{
                print(quests.first)
            }catch{
                print(error)
            }
            
        }
    }
    
    func add() {
        let uuid =  UUID()
        let uuidstring = uuid.uuidString
        do{
            let descriptor = FetchDescriptor<Quest>(predicate: #Predicate<Quest>{$0.title == questTitle})
            let currentQuest = try context.fetch(descriptor).first
            let data = Photo(saveDate: Date(), photoData: image.jpegData(compressionQuality: 1)!, scale: scale, center: position, registerSns: [], best: true,questTitle: questTitle,id: uuidstring)
            context.insert(data)
            currentQuest?.ids.append(uuidstring)
            print(currentQuest?.ids)
        }catch{
            print(error)
        }
        dismissToRoot()
//        dismiss()
        onDismiss()
//        print(context)
        }
}

//#Preview {
//    PhotoTrimmingView()
//}
