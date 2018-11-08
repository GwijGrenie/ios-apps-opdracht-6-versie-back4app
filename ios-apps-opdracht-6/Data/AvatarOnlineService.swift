import Foundation
import Parse

class AvatarOnlineService : AvatarService {

    init() {}
    
    func getAllInBackground(Listener weakListener: AvatarServiceAllCallback?) {
        
        let query = PFQuery(className: "Avatar")
        query.findObjectsInBackground(block: { (objects, error) in
            
            var avatars : [Avatar] = []
            
            if(error == nil) {
                if let unwrappedObjects = objects {
                    for object in unwrappedObjects {
                        avatars.append(DataUnwrappingHelper.unwrapAvatar(WrappedAvatar: object))
                    }
                }
            }
            
            guard let listener = weakListener else {
                return
            }
            
            listener.onAllReceived(avatars, error)
        })
    }
    
    
}
