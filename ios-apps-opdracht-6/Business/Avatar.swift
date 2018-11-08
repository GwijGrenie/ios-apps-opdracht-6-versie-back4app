import Foundation

class Avatar {
    var image : Data
    
    init() {
        image = Data()
    }
    
    init(Image image: Data) {
        self.image = image
    }
}
