import Foundation

class Member {
    
    var id: String
    var name: String
    var children: Int
    var isMale: Bool
    var image: Data
    
    init() {
        id = String()
        name = String()
        children = Int()
        isMale = Bool()
        image = Data()
    }
    
    init(Id id: String, Name name: String, Children children: Int, IsMale isMale: Bool, Image image: Data) {
        self.id = id
        self.name = name
        self.children = children
        self.isMale = isMale
        self.image = image
    }
}
