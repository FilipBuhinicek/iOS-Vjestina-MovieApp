//
//  LogInViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 28.03.2023..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class LogInViewController: UIViewController {
    
    private var mainLabel: UILabel!
    private var emailLabel: UILabel!
    private var passLabel: UILabel!
    private var emailField: UITextField!
    private var passField: UITextField!
    private var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    func signInLabel(){
        mainLabel = UILabel()
        view.addSubview(mainLabel)
        mainLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        mainLabel.textColor = .white
        mainLabel.font = UIFont.systemFont(ofSize: 24)
        mainLabel.textAlignment = .center
        mainLabel.text = "Sign in"
        
        mainLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 50)
        mainLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
    }
    
    func emaillabel(){
        
        emailLabel = UILabel()
        view.addSubview(emailLabel)
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.text = "Email address"
        emailLabel.textColor = .white
        
        emailLabel.autoPinEdge(.top, to: .bottom, of: mainLabel, withOffset: 36)
        emailLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
        
        emailLabel.autoSetDimensions(to: CGSize(width: 95, height: 20))
        
    }
    
    func emailfield(){
    
        emailField = UITextField()
        view.addSubview(emailField)
        emailField.attributedPlaceholder = NSAttributedString(string: "ex. Matt@iosCourse.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.cyan])
        emailField.autoSetDimensions(to: CGSize(width: 358, height: 48))
        emailField.backgroundColor = UIColor(red: 0.073, green: 0.23, blue: 0.387, alpha: 1)
        emailField.layer.borderColor = CGColor(red: 0.082, green: 0.302, blue: 0.521, alpha: 1)
        emailField.layer.cornerRadius = 10
        emailField.layer.borderWidth = 1
        emailField.textColor = .cyan
        
        let pomak1 = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: emailField.frame.height))
        emailField.leftView = pomak1
        emailField.leftViewMode = .always
        
        emailField.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 6)
        emailField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
    }
    
    func passlabel(){
        
        passLabel = UILabel()
        view.addSubview(passLabel)
        passLabel.font = UIFont.systemFont(ofSize: 14)
        passLabel.text = "Password"
        passLabel.textColor = .white
        
        passLabel.autoPinEdge(.top, to: .bottom, of: emailField, withOffset: 18)
        passLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
        
        passLabel.autoSetDimensions(to: CGSize(width: 95, height: 20))
        
    }
    
    func passfield(){
    
        passField = UITextField()
        view.addSubview(passField)
        passField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.cyan])
        passField.autoSetDimensions(to: CGSize(width: 358, height: 48))
        passField.backgroundColor = UIColor(red: 0.073, green: 0.23, blue: 0.387, alpha: 1)
        passField.layer.borderColor = CGColor(red: 0.082, green: 0.302, blue: 0.521, alpha: 1)
        passField.layer.cornerRadius = 10
        passField.layer.borderWidth = 1
        passField.textColor = .cyan
        
        let pomak2 = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: passField.frame.height))
        passField.leftView = pomak2
        passField.leftViewMode = .always
        
        passField.autoPinEdge(.top, to: .bottom, of: passLabel, withOffset: 6)
        passField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
    }
    func buttonfunc(){
        button = UIButton()
        view.addSubview(button)
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        
        button.autoPinEdge(.top, to: .bottom, of: passField, withOffset: 36)
        button.autoAlignAxis(toSuperviewAxis: .vertical)
        button.autoSetDimensions(to: CGSize(width: 326, height: 40))
        button.layer.cornerRadius = 10

    }
    
    
    func buildView(){
        view.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.2, alpha: 1)
        signInLabel()
        emaillabel()
        emailfield()
        passlabel()
        passfield()
        buttonfunc()
    
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let novaSirina = size.height
        let novaVisina = size.width
        
        view.frame = CGRect(x: 0, y: 0, width: novaSirina, height: novaVisina)
    }
}
