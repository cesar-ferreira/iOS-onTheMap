//
//  ViewController.swift
//  onTheMap
//
//  Created by César Ferreira on 05/04/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

    @IBAction func loginTapped(_ sender: Any) {
        viewModel.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}

extension LoginViewController: LoginViewModelProtocol {
    func didLogin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}
