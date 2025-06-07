import SwiftUI
import SwiftData
import AVFoundation

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query private var quests: [Quest]
    @State var flag = false
    @State var questTitle = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
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
//                                if let photoData = quest.id.first?,
//                                   let
//                                   let uiImage = UIImage(data: photoData) {
//                                    Image(uiImage: uiImage)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 80)
//                                        .clipShape(Circle())
//                                        .shadow(radius: 3)
//                                } else {
//                                    Image(systemName: "camera")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 80)
//                                        .clipShape(Circle())
//                                        .shadow(radius: 3)
//                                }
                            }
                        }
                        .frame(width:UIScreen.main.bounds.width / 2 - 30 , height: (UIScreen.main.bounds.width / 2 - 30) / 4 * 5)
                        .onTapGesture {
                            let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                            if status == AVAuthorizationStatus.authorized {
                                questTitle = quest.title
                                flag = true
                                print(quests.first)
                            }else{
                                AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
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
                    
                    try context.save()
                    print("saved")
                }catch{
                    print(error)
                }
                
            }
            .navigationDestination(isPresented: $flag) {
                CameraView(quest: $questTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle($questTitle)
                    
                    
            }
            .navigationTitle("クエスト一覧")
            .navigationBarTitleDisplayMode(.large)
            
        }
        
        
        
    }

}

//#Preview {
//    HomeView()
//}
