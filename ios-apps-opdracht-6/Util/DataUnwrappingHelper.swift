import Foundation
import Parse

class DataUnwrappingHelper {
    
    private init(){}
    
    static func unwrapMember(WrappedMember wrappedMember : PFObject) -> Member {
        
        let id = wrappedMember.objectId
        let name = wrappedMember["name"] as! String
        let children = wrappedMember["children"] as! Int
        
        let imageFile = wrappedMember["image"] as! PFFile
        var image : Data
        
        do {
            image = try imageFile.getData()
        }  catch {
            image = Data()
        }
        
        let isMale = wrappedMember["isMale"] as! Bool
        
        return Member(Id: id!, Name: name, Children: children, IsMale: isMale, Image: image)
    }
    
    static func unwrapAvatar(WrappedAvatar wrappedAvatar : PFObject) -> Avatar {
        
        let imageFile = wrappedAvatar["image"] as! PFFile
        var image : Data
        
        do {
            image = try imageFile.getData()
        } catch {
            image = Data()
        }
        
        return Avatar(Image: image)
    }
    
}
