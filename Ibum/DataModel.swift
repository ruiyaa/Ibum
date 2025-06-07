import Foundation
import SwiftData

//・保存日
//・元画像のデータ
//・スケール
//・中心座標
//・登録SNS

@Model
final class Photo{
    var saveDate:Date
    var photoData:Data
    var scale:CGFloat
    var center:CGPoint
    var registerSns:[String]
    var best:Bool
    var questTitle:String
    var id:String
    
    init(saveDate: Date, photoData: Data, scale: CGFloat, center: CGPoint, registerSns: [String], best: Bool,questTitle:String,id:String) {
        self.saveDate = saveDate
        self.photoData = photoData
        self.scale = scale
        self.center = center
        self.registerSns = registerSns
        self.best = best
        self.questTitle = questTitle
        self.id = id
    }
}


