import Foundation

protocol MemberService {
    func get(_ id : String) -> Member?
    func getAllInBackground(Listener weakListener : MemberServiceAllCallback?)
    func create(_ member : Member)
    func update(_ member : Member)
    func delete(_ id : String)
}

protocol MemberServiceAllCallback {
    func onAllReceived(_ members : [Member], _ error : Error?)
}
