
import UIKit

class SelectDropDownVC: UIViewController {
    
    @IBOutlet weak var cornerRadiusView: CornerRadiusOnView!
    @IBOutlet weak var classesTV: UITableView!
    @IBOutlet weak var dismissingView: UIButton!
    var infoAdress = ""
//    private let dropList:[String] = ["Post Graduate", "Graduate","HSC/Diploma" , "SSC", "Required"]
//    private let dropListstate:[String] = ["Maharashtra", "Gujarat","Karnataka","Madhya Pradesh", "Delhi","“Others"]

    var callback:((_ selectedClass: String) ->())?
    
    @IBAction func dismissedAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classesTV.delegate = self
        classesTV.dataSource = self
        classesTV.reloadData()
    }
    

    

}

extension SelectDropDownVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if infoAdress ==  "infoAdress"
        {
            return Education.allCases.count
        }
        else
        {
            return States.allCases.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = classesTV.dequeueReusableCell(withIdentifier: "DropSelections", for: indexPath) as! DropSelections
        if infoAdress ==  "infoAdress"
        {
         cell.classesShowing.text =  Education.allCases[indexPath.row].rawValue
        }
        else
        {
            cell.classesShowing.text = States.allCases[indexPath.row].rawValue
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if infoAdress ==  "infoAdress"
        {
            let showingSelectedClass: String = Education.allCases[indexPath.row].rawValue
            callback?(showingSelectedClass)
            tableView.deselectRow(at: indexPath, animated: true)
            self.dismiss(animated: true)
        }
        else
        {
            let showingState: String = States.allCases[indexPath.row].rawValue
            callback?(showingState)
            tableView.deselectRow(at: indexPath, animated: true)
            self.dismiss(animated: true)
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
