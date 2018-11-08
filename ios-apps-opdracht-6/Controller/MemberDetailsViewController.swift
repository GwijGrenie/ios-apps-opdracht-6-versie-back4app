import UIKit

class MemberDetailsViewController: UIViewController {

    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldChildren: UITextField!
    @IBOutlet weak var stepperChildren: UIStepper!
    @IBOutlet weak var segmentedControlSex: UISegmentedControl!
    
    var member : Member! = nil
    
    private var memberImage : Data? = nil
    private var memberName : String! = nil
    private var memberChildren : Int! = nil
    private var memberIsMale : Bool! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberImage = member.image
        memberName = member.name
        memberChildren = member.children
        memberIsMale = member.isMale
        
        initFields()
    }
    
    // MARK: callback handlers
    
    @IBAction func onChildrenStepperValueChanged(_ sender: UIStepper) {
        memberChildren = Int(stepperChildren.value)
        textFieldChildren.text = String(memberChildren)
    }
    
    @IBAction func onSexSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            memberIsMale = true
            break
        case 1:
            memberIsMale = false
            break
        default:
            break
        }
    }
    
    // MARK: helpers
    
    private func initFields() {
        
        if let unwrappedMemberImage = memberImage {
            imageAvatar.image = UIImage(data: unwrappedMemberImage)
        } else {
            
        }
        
        textFieldName.text = memberName
        
        stepperChildren.value = Double(memberChildren)
        textFieldChildren.text = String(memberChildren)
        
        segmentedControlSex.selectedSegmentIndex = memberIsMale ? 0 : 1
    }
}
