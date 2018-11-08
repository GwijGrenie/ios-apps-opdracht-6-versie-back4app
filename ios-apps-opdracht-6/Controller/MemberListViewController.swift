import UIKit

class MemberListViewController: UITableViewController {

    private let memberListPresenter = MemberListPresenter(memberService: MemberOnlineService())
    private var members : [MemberViewData] = []
    
    private var activityIndicator : UIActivityIndicatorView
    
    required init?(coder aDecoder : NSCoder) {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        super.init(coder : aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initActivityIndicator()
        
        memberListPresenter.attachView(self)
        memberListPresenter.getMembers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    private func initActivityIndicator() {
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
}

extension MemberListViewController {

    // MARK : Table Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "prototypeCellMember"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MemberCell else {
            fatalError("The dequeued cell is not an instance of MemberCell.")
        }
        
        let member = members[indexPath.row]
        cell.labelTitle.text = member.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK : Table Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //currentMember = members[indexPath.row]
        //performSegue(withIdentifier: "memberDetails", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            tableView.deselectRow(at: index, animated: true)
            self.memberListPresenter.deleteMember(self.members[index.row].id)
        }
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }
}

extension MemberListViewController : MemberListView {
    
    // MARK : Presenter Delegate
    
    func startLoading() {
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = UIColor.white
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func setMembers(_ members: [MemberViewData]) {
        self.members = members
        self.tableView.reloadData()
    }
}
