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
    
    init(saveDate: Date, photoData: Data, scale: CGFloat, center: CGPoint, registerSns: [String], best: Bool,questTitle:String) {
        self.saveDate = saveDate
        self.photoData = photoData
        self.scale = scale
        self.center = center
        self.registerSns = registerSns
        self.best = best
        self.questTitle = questTitle
    }
}

//クエスト
//・タグ
//・お気に入り
//・画像データ
//・クリア済か否か
//・タイトル

@Model
final class Quest{
    var title:String
    var phots:[Photo]
    var tags:[TagSet]
    var favorite:Bool
    var clear:Bool
    
    init(title: String, phots: [Photo], tags: [TagSet], favorite: Bool, clear: Bool) {
        self.title = title
        self.phots = phots
        self.tags = tags
        self.favorite = favorite
        self.clear = clear
    }
}


