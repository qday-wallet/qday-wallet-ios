//
//  Web3AuthViewController.swift
//  NBWallet
//
//  Created by Qiyeyun2 on 2024/7/17.
//

import UIKit
import SnapKit
import Web3Auth
import Toast_Swift

class Web3AuthViewController: UIViewController {
    
    lazy var googleAuth_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.setImage(UIImage(named: "google"), for: .normal)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8");
        v.layer.cornerRadius = 20;
        v.layer.masksToBounds = true;
        v.addTarget(self, action: #selector(googleAuth_btnClick), for: .touchUpInside)
        return v
    }()
    
    lazy var githubAuth_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.setImage(UIImage(named: "github"), for: .normal)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8");
        v.layer.cornerRadius = 20;
        v.layer.masksToBounds = true;
        v.addTarget(self, action: #selector(githubAuth_btnClick), for: .touchUpInside)
        return v
    }()
    
    
    lazy var facebookAuth_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.setImage(UIImage(named: "facebook"), for: .normal)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8");
        v.layer.cornerRadius = 20;
        v.layer.masksToBounds = true;
        v.addTarget(self, action: #selector(facebookAuth_btnClick), for: .touchUpInside)
        return v
    }()
    
    lazy var twitterAuth_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.setImage(UIImage(named: "twitter"), for: .normal)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8");
        v.layer.cornerRadius = 20;
        v.layer.masksToBounds = true;
        v.addTarget(self, action: #selector(twitterAuth_btnClick), for: .touchUpInside)
        return v
    }()
    
    
    lazy var openAllApp_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8");
        v.layer.cornerRadius = 20;
        v.layer.masksToBounds = true;
        v.addTarget(self, action: #selector(openAllApp_btnClick), for: .touchUpInside)
        return v
    }()
    
    lazy var title_label: UILabel = {
        let v = UILabel()
        v.text = "Sign In";
        v.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return v
    }()
    
    lazy var appTitle_label: UILabel = {
        let v = UILabel()
        v.text = "contine with:";
        v.textColor = UIColor.colorWithHexString(hexString: "#a0a0a0")
        v.font = UIFont.systemFont(ofSize: 15)
        return v
    }()
    
    lazy var AppStack: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.distribution = .fill;
        v.spacing = 10;
        return v
    }()
    
    lazy var firstAppStack: UIStackView = {
        let v = UIStackView()
        v.distribution = .equalSpacing;
        return v
    }()
    
    lazy var secondAppStack: UIStackView = {
        let v = UIStackView()
        return v
    }()
    
    lazy var appLine_view: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#d9d9d9")
        return v
    }()
    
    lazy var emailTitle_label: UILabel = {
        let v = UILabel()
        v.text = "email";
        v.textColor = UIColor.colorWithHexString(hexString: "#a0a0a0")
        v.font = UIFont.systemFont(ofSize: 15)
        return v
    }()
    
    lazy var email_tf: UITextField = {
        let paddingV = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let v = UITextField()
        v.leftView = paddingV;
        v.leftViewMode = .always;
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8")
        v.layer.cornerRadius = 20;
        v.placeholder = "Email";
        v.layer.masksToBounds = true;
        return v
    }()
    
    lazy var emailLogin_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#4680ff");
        v.setTitle("Contine with Email", for: .normal)
        v.layer.cornerRadius = 20;
        v.layer.masksToBounds = true;
        v.addTarget(self, action: #selector(emailLogin_btnClick), for: .touchUpInside)
        return v
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white;
        //
        self.setupUI();
        //
        self.initWeb3Auth()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func setupUI() {
        //
        self.view.addSubview(self.title_label);
        
        self.title_label.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        //
        self.view.addSubview(self.appTitle_label);
        self.view.addSubview(self.AppStack);
        self.view.addSubview(self.appLine_view);
        
        
        self.appTitle_label.snp.makeConstraints { make in
            make.top.equalTo(self.title_label.snp.bottom).offset(30);
            make.left.equalTo(30)
        }
        
        self.AppStack.snp.makeConstraints { make in
            make.top.equalTo(self.appTitle_label.snp.bottom).offset(20);
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        self.appLine_view.snp.makeConstraints { make in
            make.top.equalTo(self.AppStack.snp.bottom).offset(20);
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(0.5)
        }
        
        self.googleAuth_btn.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        self.githubAuth_btn.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        self.facebookAuth_btn.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        self.twitterAuth_btn.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        self.openAllApp_btn.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        self.AppStack.addArrangedSubview(self.firstAppStack);
        self.AppStack.addArrangedSubview(self.secondAppStack);
        
        self.firstAppStack.addArrangedSubview(self.googleAuth_btn);
        self.firstAppStack.addArrangedSubview(self.githubAuth_btn);
        self.firstAppStack.addArrangedSubview(self.facebookAuth_btn);
        self.firstAppStack.addArrangedSubview(self.twitterAuth_btn);
//        self.firstAppStack.addArrangedSubview(self.openAllApp_btn);
        
        //
        self.view.addSubview(self.emailTitle_label);
        self.view.addSubview(self.email_tf);
        self.view.addSubview(self.emailLogin_btn);
        
        self.emailTitle_label.snp.makeConstraints { make in
            make.top.equalTo(self.appLine_view.snp.bottom).offset(30);
            make.left.equalTo(30)
        }
        
        self.email_tf.snp.makeConstraints { make in
            make.top.equalTo(self.emailTitle_label.snp.bottom).offset(20);
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(40)
        }
        
        self.emailLogin_btn.snp.makeConstraints { make in
            make.top.equalTo(self.email_tf.snp.bottom).offset(10);
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(40)
        }
    }
    
    func initWeb3Auth() {
        Task {
            do {
                try await Web3AuthManager.share.initWeb3Auth()
            } catch {
                
            }
        }
    }
    
    @objc
    func googleAuth_btnClick() {
        Task {
            do {
                let state = try await Web3AuthManager.share.login(provider: .GOOGLE);
                //
                self.gotoHome(state: state)
            } catch {
                
            }
        }
    }
    
    @objc
    func githubAuth_btnClick() {
        Task {
            do {
                let state = try await Web3AuthManager.share.login(provider: .GITHUB);
                //
                self.gotoHome(state: state)
            } catch {
                
            }
        }
    }
    
    @objc
    func openAllApp_btnClick() {
        
    }
    
    @objc
    func facebookAuth_btnClick() {
        Task {
            do {
                let state = try await Web3AuthManager.share.login(provider: .FACEBOOK);
                //
                self.gotoHome(state: state)
            } catch {
                
            }
        }
    }
    
    @objc
    func twitterAuth_btnClick() {
        Task {
            do {
                let state = try await Web3AuthManager.share.login(provider: .TWITTER);
                //
                self.gotoHome(state: state)
            } catch {
                
            }
        }
    }
    
    
    @objc
    func emailLogin_btnClick() {
        if self.email_tf.text?.count == 0 {
            self.view.makeToast("Email Empty");
            return
        }
        
        Task {
            do {
                let state = try await Web3AuthManager.share.login(email: self.email_tf.text!);
                //
                self.gotoHome(state: state)
            } catch {
                
            }
        }
    }
    
    @MainActor
    func gotoHome(state:Web3AuthState?) {
        let deletate = UIApplication.shared.delegate as? AppDelegate
        let vc = HomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        deletate?.window?.rootViewController = nav;
    }

}
