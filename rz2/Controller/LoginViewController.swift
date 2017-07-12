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


//MARK: - Structs
struct Segues {
    static let Units = "unitsTableViewSegue"
}

struct LoginCredentials {
    static let email = "mobile@gmail.com"
    static let password = "1234"
}

class LoginViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var logoImage: UIImageView!
    
    //MARK: - Models
    var items = [NSManagedObject]()
    private var company : Company? {
        didSet {
            self.getUnits()
        }
    }
    
    //MARK: - Vars
    //variaveis para controle de finalização da animação
    var animationCompleted : Bool = false
    var objectsFinishedFetch : Bool = false

    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginAnimation()
        self.doLogin(email: LoginCredentials.email, password: LoginCredentials.password)
    }
    
    //MARK: - Actions
    //Realiza login com as credenciais pertencentes a struct LoginCredentials
    func doLogin(email: String, password: String) {
        let params = [
            "email" : email,
            "password" : password
        ]
        Company.login(params: params, completionBlock: {
            (company, error) in
            if error == nil {
                self.company = company
            }
        })
    }
    
    //Após login feito, para buscar as unidades, realiza um get com o token e persiste os dados no CoreData e termina a animação
    func getUnits() {
        self.company?.getUnits() {
            (units, error) in
            if let jsons = units {
                debugPrint(jsons)
                let store = Store()
                store.save(Json: jsons, completionBlock: { (success, error) in
                    if success {
                        if self.animationCompleted {
                            self.completeAnimation()
                        } else {
                            self.objectsFinishedFetch = true
                        }
                    }
                })
            }
        }
    }

    //MARK: - Animation
    //Animação enquanto está sendo realizada as chamadas de login e buscar unidades do WS
    func beginAnimation() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: UIViewAnimationOptions.curveEaseOut,
            animations: {
                self.logoImage.alpha = 1
        }) {
            completed in
            if completed {
                if self.objectsFinishedFetch {
                    self.completeAnimation()
                } else {
                    self.animationCompleted = true
                }
            }
        }
    }
    
    func completeAnimation(){
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: UIViewAnimationOptions.curveEaseIn,
            animations: {
                self.logoImage.alpha = 0
        }){
            completed in
            self.performSegue(withIdentifier: Segues.Units, sender: nil)
        }
    }
    
    

}
