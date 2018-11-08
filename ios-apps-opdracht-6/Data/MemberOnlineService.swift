import Foundation
import Parse

class MemberOnlineService : MemberService {

    private static var cachedMembersMappedToId : [String : Member]! = [:]
    
    init() {}
    
    func get(_ id: String) -> Member? {
        return MemberOnlineService.cachedMembersMappedToId[id]
    }
    
    func getAllInBackground(Listener listener: MemberServiceAllCallback?) {
        
        if MemberOnlineService.cachedMembersMappedToId.isEmpty {
            
            let query = PFQuery(className: "Member")
            query.findObjectsInBackground(block: { (objects, error) in
                
                var membersMappedToId : [String : Member] = [:]
                
                if error == nil {
                    if let unwrappedObjects = objects {
                        for object in unwrappedObjects {
                            let unwrappedMember = DataUnwrappingHelper.unwrapMember(WrappedMember: object)
                            membersMappedToId[unwrappedMember.id] = unwrappedMember
                        }
                    }
                }
                
                MemberOnlineService.cachedMembersMappedToId = membersMappedToId
                listener?.onAllReceived(self.getCachedValues(), error)
            })
        } else {
            listener?.onAllReceived(getCachedValues(), nil)
        }
    }
    
    func create(_ member: Member) {
        let id = String(MemberOnlineService.cachedMembersMappedToId.count)
        MemberOnlineService.cachedMembersMappedToId[member.id] = Member(Id: id, Name: member.name, Children: member.children, IsMale: member.isMale, Image: member.image)
    }
    
    func update(_ member: Member) {
        if MemberOnlineService.cachedMembersMappedToId[member.id] != nil {
            MemberOnlineService.cachedMembersMappedToId[member.id] = member
        }
    }
    
    func delete(_ id: String) {
        if MemberOnlineService.cachedMembersMappedToId[id] != nil {
            MemberOnlineService.cachedMembersMappedToId.removeValue(forKey: id)
        }
    }
    
    private func getCachedValues() -> [Member] {
        var members : [Member] = []
        members = MemberOnlineService.cachedMembersMappedToId.map({(key, value) -> Member in return value})
        return members
    }
}
