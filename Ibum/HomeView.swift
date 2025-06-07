import SwiftUI
import SwiftData
import AVFoundation

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}

struct HomeView: View {
    @Environment(\.modelContext) private var context
    
    
    @StateObject private var isPresentedCamera = isPresenteCamera()
    
    
    @Query private var quests: [Quest]
    @State var flag = false
    @State var questTitle = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var showViewController = false
    
    var body: some View {
        
        NavigationStack{
            ScrollView(.vertical){
                LazyVGrid(columns: columns, spacing:10){
                    ForEach(quests,id:\.self){ quest in
                       
                            ZStack{
                                RoundedRectangle(cornerRadius: 20, style: .circular)
                                    .fill(.white)
                                    .frame(width:UIScreen.main.bounds.width / 2 - 30 , height: (UIScreen.main.bounds.width / 2 - 30) / 4 * 5)
                                    .shadow(radius: 3)
                                
                                VStack{
                                    HStack{
                                        ForEach(quest.tags,id:\.self){tag in
                                            Text("#" + String(tag.rawValue))
                                        }
                                        Spacer()
                                        Image(systemName: (quest.clear ? "star.fill" : "star"))
                                    }
                                    Text(String(quest.title))
                                    if let idd = quest.ids.first{
                                        let descriptor = FetchDescriptor<Photo>(predicate: #Predicate<Photo>{$0.id == idd})
                                        if let currentPhoto = try! context.fetch(descriptor).first as? Photo,
                                           let uiImage = UIImage(data: currentPhoto.photoData) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80)
                                                .clipShape(Circle())
                                                .shadow(radius: 3)
                                        }
                                    } else {
                                        Image(systemName: "camera")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80)
                                            .clipShape(Circle())
                                            .shadow(radius: 3)
                                    }
                                    
                                    
                                }
                            }
                            .frame(width:UIScreen.main.bounds.width / 2 - 30 , height: (UIScreen.main.bounds.width / 2 - 30) / 4 * 5)
                            .onTapGesture {
                                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                                if status == AVAuthorizationStatus.authorized {
                                    questTitle = quest.title
//                                    flag = true
                                    print(quests.first)
                                    //                                isPresented = true
//                                    isPresentedCamera.isOn = true
                                    print("aaaaafsdf")
                                    if !showViewController {
                                        showViewController = true
                                    }
                                    
                                    
                                }else{
                                    AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
//                                        showViewController = true
                                    })
                                }
                            }
                        }
                        
                    
                    
                    
                }

            }
            .onAppear{
                let questdatabase = QuestDatabase()
                if quests.isEmpty{
                    for item in questdatabase.items{
                        context.insert(item)
                    }
                    print("saved2")
                }
                do{
                    
//                    try context.save()
                    print("saved")
                }catch{
                    print(error)
                }
                
            }
            .navigationTitle("クエスト一覧")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(isPresented: $showViewController){
                CameraView(quest: $questTitle,isActive: $showViewController)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle($questTitle)
            }
//            .background(
//                NavigationLink(isP)
//                NavigationLink(isPresented:$showViewController){
//                    
//                }
//            )
            
        }
        
        
        
    }

}

//#Preview {
//    HomeView()
//}

class isPresenteCamera: ObservableObject {
    
    @Published var isOn = true
    
}
