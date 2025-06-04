import SwiftUI
import SwiftData
import AVFoundation

struct HomeView: View {
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
            
        }
    }
}

#Preview {
    HomeView()
}
