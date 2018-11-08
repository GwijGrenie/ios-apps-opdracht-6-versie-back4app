import Foundation

protocol MemberListView : AnyObject {
    func startLoading()
    func finishLoading()
    func setMembers(_ members : [MemberViewData])
}

class MemberListPresenter {
    
    private let memberService : MemberService
    weak private var memberListView : MemberListView?
    
    init(memberService : MemberService) {
        self.memberService = memberService
    }
    
    func attachView(_ memberListView : MemberListView) {
        self.memberListView = memberListView
    }
    
    func detachView() {
        memberListView = nil
    }
    
    func getMembers() {
        memberListView?.startLoading()
        memberService.getAllInBackground(Listener: self)
    }
    
    func deleteMember(_ id : String) {
        memberService.delete(id)
        memberListView?.startLoading()
        memberService.getAllInBackground(Listener: self)
    }
}

extension MemberListPresenter : MemberServiceAllCallback {
    
    func onAllReceived(_ members: [Member], _ error: Error?) {
        if error == nil {
            let memberViewData = members.map({ (member) -> MemberViewData in
                return MemberViewData(id: member.id, name: member.name, children: String(member.children), isMale: member.isMale, image: member.image) })
            memberListView?.finishLoading()
            memberListView?.setMembers(memberViewData)
        }
    }
    
}
