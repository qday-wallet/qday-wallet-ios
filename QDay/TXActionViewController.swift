//
//  TXActionViewController.swift
//  NBWallet
//
//  Created by Qiyeyun2 on 2024/7/26.
//

import UIKit
import SnapKit
import Toast_Swift
import Alamofire
import SwiftyJSON

class TXActionViewController: UIViewController {
    
    var myAddress: String = "";
    var privateKey: String = "";
    
    lazy var title_label: UILabel = {
        let v = UILabel()
        v.text = "Edit Transaction";
        v.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return v
    }()
    
    lazy var close_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.addTarget(self, action: #selector(close_btnClick), for: .touchUpInside)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8")
        v.setImage(UIImage(named: "close"), for: .normal)
        v.layer.cornerRadius = 22;
        return v
    }()
    
    lazy var from_label: UILabel = {
        let v = UILabel()
        v.text = "From Address";
        return v
    }()
    
    lazy var from_tf: UITextField = {
        let paddingV = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let v = UITextField()
        v.leftView = paddingV;
        v.leftViewMode = .always;
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8")
        v.layer.cornerRadius = 20;
        v.text = myAddress;
        v.isEnabled = false;
        v.placeholder = "From Address";
        v.layer.masksToBounds = true;
        return v
    }()
    
    lazy var to_label: UILabel = {
        let v = UILabel()
        v.text = "Receiver Address";
        return v
    }()
    
    lazy var to_tf: UITextField = {
        let paddingV = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let v = UITextField()
        v.leftView = paddingV;
        v.leftViewMode = .always;
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8")
        v.layer.cornerRadius = 20;
        v.placeholder = "Receiver Address";
        v.layer.masksToBounds = true;
        return v
    }()
    
    lazy var scan_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#4680ff")
        v.setTitle("Scan", for: .normal)
        v.addTarget(self, action: #selector(scan_btnClick), for: .touchUpInside)
        v.layer.cornerRadius = 10;
        return v
    }()
    
    lazy var amount_label: UILabel = {
        let v = UILabel()
        v.text = "Amount";
        return v
    }()
    
    lazy var amount_tf: UITextField = {
        let paddingV = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let v = UITextField()
        v.leftView = paddingV;
        v.leftViewMode = .always;
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8")
        v.layer.cornerRadius = 20;
        v.placeholder = "Amount";
        v.layer.masksToBounds = true;
        v.keyboardType = .decimalPad;
        return v
    }()
    
    lazy var submit_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.setTitle("Submit", for: .normal)
        v.addTarget(self, action: #selector(submit_btnClick), for: .touchUpInside)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#4680ff");
        v.layer.cornerRadius = 10;
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        //
        self.view.addSubview(self.title_label)
        self.view.addSubview(self.close_btn)
        self.view.addSubview(self.from_label)
        self.view.addSubview(self.from_tf)
        self.view.addSubview(self.to_label)
        self.view.addSubview(self.to_tf)
        self.view.addSubview(self.scan_btn);
        self.view.addSubview(self.amount_label)
        self.view.addSubview(self.amount_tf)
        self.view.addSubview(self.submit_btn)
        
        //
        self.title_label.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30);
        }
        self.close_btn.snp.makeConstraints { make in
            make.centerY.equalTo(self.title_label.snp.centerY)
            make.right.equalTo(-15)
            make.width.height.equalTo(44)
        }
        self.from_label.snp.makeConstraints { make in
            make.top.equalTo(self.title_label.snp.bottom).offset(30)
            make.left.equalTo(15);
        }
        self.from_tf.snp.makeConstraints { make in
            make.top.equalTo(self.from_label.snp.bottom).offset(10)
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(40)
        }
        self.to_label.snp.makeConstraints { make in
            make.top.equalTo(self.from_tf.snp.bottom).offset(30)
            make.left.equalTo(15);
        }
        self.scan_btn.snp.makeConstraints { make in
            make.top.equalTo(self.to_label.snp.bottom).offset(10)
            make.right.equalTo(-15);
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        self.to_tf.snp.makeConstraints { make in
            make.top.equalTo(self.to_label.snp.bottom).offset(10)
            make.left.equalTo(15);
            make.right.equalTo(self.scan_btn.snp.left).offset(-10);
            make.height.equalTo(40)
        }
        self.amount_label.snp.makeConstraints { make in
            make.top.equalTo(self.to_tf.snp.bottom).offset(30)
            make.left.equalTo(15);
        }
        self.amount_tf.snp.makeConstraints { make in
            make.top.equalTo(self.amount_label.snp.bottom).offset(10)
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(40)
        }
        
        self.submit_btn.snp.makeConstraints { make in
            make.top.equalTo(self.amount_tf.snp.bottom).offset(30)
            make.left.equalTo(30);
            make.right.equalTo(-30);
            make.height.equalTo(40)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @objc
    func close_btnClick() {
        self.dismiss(animated: true)
    }
    
    @objc
    func submit_btnClick() {
        guard var from = self.from_tf.text, from.count > 0 else {
            self.view.makeToast("from address empty")
            return
        }
        
        guard var to = self.to_tf.text, to.count > 0 else {
            self.view.makeToast("receiver address empty")
            return
        }
        
        guard let amountStr = self.amount_tf.text, let amount = Float(amountStr) else {
            self.view.makeToast("amount address empty")
            return
        }
        let params: [String: Any] = [
            "key":self.privateKey,
            "from":from,
            "to":to,
            "value": amount*ACCURACY
        ];
        
        self.view.makeToastActivity(.center);
        AF.request(encryptTXAPI,method: .post,parameters:params, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let delayInSeconds = 3.0
                DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                    self.view.hideToastActivity();
                    self.dismiss(animated: true);
                }
                
            case .failure(let error):
                self.view.hideToastActivity();
                self.view.makeToast("tx fail");
            }
        })
    }
    
    @objc
    func scan_btnClick() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return;
        }
        let vc = ScanViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self;
        self.present(vc, animated: true)
        
    }

}

extension TXActionViewController: ScanViewControllerDelete {
    func scanResult(result: String) {
        self.to_tf.text = result
    }
}
