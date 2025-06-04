import SwiftUI
import SwiftData
import AVFoundation

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query private var quests: [Quest]
    @State var flag = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Button(action: {
                    let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                    if status == AVAuthorizationStatus.authorized {
                        flag = true
                    }else{
                        print(status.rawValue)
                        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                        })
                    }
                }, label: {
                    Text("camera")
                })
                NavigationLink("camera"){
                    CameraView()
                        .navigationTitle("笑顔でピース")
//                        .navigationBarBackButtonHidden(true)
                }

            }
            
        }.onAppear{
            let questdatabase = QuestDatabase()
            if quests.isEmpty{
                for item in questdatabase.items{
                    context.insert(item)
                }
            }
        }
    }

}

#Preview {
    HomeView()
}
