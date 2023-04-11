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
    
    private var signInLabel: UILabel!
    private var emailLabel: UILabel!
    private var passLabel: UILabel!
    private var emailTextField: UITextField!
    private var passTextField: UITextField!
    private var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    func createViews() {
        signInLabel = UILabel()
        view.addSubview(signInLabel)
        
        emailLabel = UILabel()
        view.addSubview(emailLabel)
        
        emailTextField = UITextField()
        view.addSubview(emailTextField)
        
        passLabel = UILabel()
        view.addSubview(passLabel)
        
        passTextField = UITextField()
        view.addSubview(passTextField)
        
        button = UIButton()
        view.addSubview(button)
    }
    
    func styleViews() {
        view.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.2, alpha: 1)
        signInLabel.textColor = .white
        signInLabel.font = .systemFont(ofSize: 24)
        signInLabel.textAlignment = .center
        signInLabel.text = "Sign in"
        
        emailLabel.font = .systemFont(ofSize: 14)
        emailLabel.text = "Email address"
        emailLabel.textColor = .white
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "ex. Matt@iosCourse.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.cyan])
        emailTextField.backgroundColor = UIColor(red: 0.073, green: 0.23, blue: 0.387, alpha: 1)
        emailTextField.layer.borderColor = CGColor(red: 0.082, green: 0.302, blue: 0.521, alpha: 1)
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1
        emailTextField.textColor = .cyan
        let leftShift1 = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: emailTextField.frame.height))
        emailTextField.leftView = leftShift1
        emailTextField.leftViewMode = .always
        
        passLabel.font = .systemFont(ofSize: 14)
        passLabel.text = "Password"
        passLabel.textColor = .white
        
        passTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.cyan])
        passTextField.backgroundColor = UIColor(red: 0.073, green: 0.23, blue: 0.387, alpha: 1)
        passTextField.layer.borderColor = CGColor(red: 0.082, green: 0.302, blue: 0.521, alpha: 1)
        passTextField.layer.cornerRadius = 10
        passTextField.layer.borderWidth = 1
        passTextField.textColor = .cyan
        let leftShift2 = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: passTextField.frame.height))
        passTextField.leftView = leftShift2
        passTextField.leftViewMode = .always
        
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
    }
    
    func defineLayoutForViews() {
        signInLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        signInLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 50)
        signInLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
        
        emailLabel.autoSetDimensions(to: CGSize(width: 95, height: 20))
        emailLabel.autoPinEdge(.top, to: .bottom, of: signInLabel, withOffset: 36)
        emailLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
        
        emailTextField.autoSetDimensions(to: CGSize(width: 358, height: 48))
        emailTextField.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 6)
        emailTextField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)

        passLabel.autoPinEdge(.top, to: .bottom, of: emailTextField, withOffset: 18)
        passLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
        passLabel.autoSetDimensions(to: CGSize(width: 95, height: 20))
      
        passTextField.autoSetDimensions(to: CGSize(width: 358, height: 48))
        passTextField.autoPinEdge(.top, to: .bottom, of: passLabel, withOffset: 6)
        passTextField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
     
        button.autoSetDimensions(to: CGSize(width: 326, height: 40))
        button.autoPinEdge(.top, to: .bottom, of: passTextField, withOffset: 36)
        button.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    func buildView() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
}
