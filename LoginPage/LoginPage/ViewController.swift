//
//  ViewController.swift
//  LoginPage
//
//  Created by Nida Saraç on 15.06.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButton(_ sender: Any) {
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if email == "admin" && password == "1234" {
            
            performSegue(withIdentifier: "girisYapildi", sender: nil)
        } else {
            // Hatalı giriş durumunda bir hata mesajı gösterebilirsiniz.
            let alertController = UIAlertController(title: "Hata", message: "Geçersiz kullanıcı adı veya şifre.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        
        
        
    }
    
}

