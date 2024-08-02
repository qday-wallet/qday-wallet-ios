//
//  QRCodeViewController.swift
//  NBWallet
//
//  qday on 2024/7/26.
//

import UIKit
import SnapKit
import SGQRCode
import Toast_Swift

class QRCodeViewController: UIViewController {
    
    var address: String = ""
    
    
    lazy var qr_imgV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    lazy var address_label: UILabel = {
        let v = UILabel()
        v.textAlignment = .center;
        v.lineBreakMode = .byTruncatingMiddle;
        v.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return v
    }()
    
    lazy var copy_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.setImage(UIImage(named: "copy"), for: .normal)
        v.addTarget(self, action: #selector(copy_btnClick), for: .touchUpInside);
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white;
        
        //
        self.view.addSubview(self.close_btn);
        self.view.addSubview(self.address_label);
        self.view.addSubview(self.copy_btn);
        self.view.addSubview(self.qr_imgV);
        
        //
        self.close_btn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20);
            make.width.height.equalTo(44)
        }
        
        self.qr_imgV.snp.makeConstraints { make in
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(self.qr_imgV.snp.width);
            make.centerY.equalTo(self.view.snp.centerY);
        }
        
        self.address_label.snp.makeConstraints { make in
            make.left.equalTo(15);
            make.right.equalTo(self.copy_btn.snp.left).offset(-10);
            make.bottom.equalTo(self.qr_imgV.snp.top).offset(-20);
        }
        
        self.copy_btn.snp.makeConstraints { make in
            make.right.equalTo(-15);
            make.centerY.equalTo(self.address_label.snp.centerY);
            make.width.height.equalTo(25);
        }
        
        //
        let wh = UIScreen.main.bounds.width - 15*2.0;
        let image = SGGenerateQRCode.generateQRCode(withData: self.address, size: wh)
        self.qr_imgV.image = image;
        //
        self.address_label.text = self.address;
    }
    
    @objc
    func close_btnClick() {
        self.dismiss(animated: true)
    }
    
    @objc
    func copy_btnClick() {
        let pasteboard = UIPasteboard.general;
        pasteboard.string = address;
        self.view.makeToast("copy success");
    }

}
