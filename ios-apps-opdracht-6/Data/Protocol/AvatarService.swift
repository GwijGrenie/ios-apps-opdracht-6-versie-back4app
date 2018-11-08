import Foundation

protocol AvatarService {
    func getAllInBackground(Listener weakListener : AvatarServiceAllCallback?)
}

protocol AvatarServiceAllCallback {
    func onAllReceived(_ avatars : [Avatar], _ error : Error?)
}
