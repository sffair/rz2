//
//  LoginViewController.swift
//  rz2
//
//  Created by Fabrício Sperotto Sffair on 2017-07-11.
//  Copyright © 2017 Fabrício Sperotto Sffair. All rights reserved.
//

import UIKit
import Sync
import CoreData
import KRProgressHUD

class LoginViewController: UIViewController {

    lazy var dataStack: DataStack = DataStack(modelName: "Data")
    
    var items = [NSManagedObject]()
    
    private var company : Company? {
        didSet {
            self.company?.getUnits(token: (self.company?.token)!, completionBlock: { (units, error) in
                if let jsons = units {
                    debugPrint(jsons)
                    self.dataStack.sync(jsons, inEntityNamed: "Units", completion: { (error) in
                        if error != nil {
                            debugPrint("error = \(String(describing: error))")
                        } else {
                            KRProgressHUD.showSuccess()
                            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Units")
                            request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
                            self.items = (try! self.dataStack.viewContext.fetch(request)) as! [NSManagedObject]

                        }
                    })
                }
            })
        }
    }
    

    
    @IBOutlet weak var token: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KRProgressHUD.show()
        
        self.token.text = ""
        let params = [
            "email" : "mobile@gmail.com",
            "password" : "1234"
        ]
        
        Company.login(params: params, completionBlock: {
            (company, error) in
            debugPrint(error)
            debugPrint(company)
            
            if error == nil {
                self.company = company
            }
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
