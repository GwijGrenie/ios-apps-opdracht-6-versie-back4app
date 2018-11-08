import Foundation

protocol MemberDetailView : AnyObject {
    func setMember(_ member : MemberViewData)
}

class MemberDetailPresenter {
    
    private let memberService : MemberService
    weak private var memberDetailView : MemberDetailView?
    
    private var id: String!
    private var name: String!
    private var children: Int!
    private var isMale: Bool!
    private var image: Data!
    
    private let isMemberSet: Bool
    
    init(memberService: MemberService) {
        self.memberService = memberService
        
        id = nil
        name = nil
        children = nil
        isMale = nil
        image = nil
        
        isMemberSet = false
    }
    
    func attachView(_ memberDetailView: MemberDetailView) {
        self.memberDetailView = memberDetailView
    }
    
    func detachView() {
        memberDetailView = nil
    }
    
    func getMember(_ id: String) {
        if let member = memberService.get(id) {
            self.id = member.id
            name = member.name
            children = member.children
            isMale = member.isMale
            image = member.image
            
            memberDetailView?.setMember(MemberViewData(id: id, name: name, children: String(children), isMale: isMale, image: image))
        }
    }
    
    func setName(_ name: String) {
       self.name = name
    }
    
    func setChildren(_ children: Int) {
        self.children = children
    }
    
    func isMale(_ isMale: Bool) {
        self.isMale = isMale
    }
}
