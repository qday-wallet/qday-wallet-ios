//
//  ScanViewController.swift
//  NBWallet
//
//  Created by 621design on 2024/7/27.
//

import UIKit
import SnapKit
import SGQRCode

protocol ScanViewControllerDelete: NSObjectProtocol {
    func scanResult(result: String)
}

class ScanViewController: UIViewController {
    
    lazy var close_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.addTarget(self, action: #selector(close_btnClick), for: .touchUpInside)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#f6f7f8")
        v.setImage(UIImage(named: "close"), for: .normal)
        v.layer.cornerRadius = 22;
        return v
    }()
    
    lazy var scan: SGScanCode = {
        let v = SGScanCode();
        v.delegate = self;
        return v
    }()
    
    lazy var scanView: SGScanView = {
        let config = SGScanViewConfigure()
        let wh = UIScreen.main.bounds.width - 30 - 30;
        let y = (UIScreen.main.bounds.height - wh)/2.0;
        let x = 30.0
        config.borderColor = UIColor.colorWithHexString(hexString: "4680ff")
        config.isShowBorder = true;
        config.cornerColor = UIColor.colorWithHexString(hexString: "4680ff");
        config.color = .clear
        let v = SGScanView(frame: CGRect(x: x, y: y, width: wh, height: wh), configure: config)
        return v!
    }()
    
    weak var delegate: ScanViewControllerDelete?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 预览视图，必须设置
        self.scan.preview = self.view;
        
        //
        self.view.addSubview(self.scanView);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scan.startRunning();
        self.scanView.stopScanning();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.scan.stopRunning();
        self.scanView.stopScanning();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        //
        self.view.addSubview(self.close_btn);
        //
        self.close_btn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20);
            make.width.height.equalTo(44)
        }
    }
    
    @objc
    func close_btnClick() {
        self.dismiss(animated: true)
    }

}

extension ScanViewController: SGScanCodeDelegate {
    func scanCode(_ scanCode: SGScanCode!, result: String!) {
        self.scan.stopRunning();
        self.scanView.stopScanning();
        self.delegate?.scanResult(result: result);
        self.dismiss(animated: true);
    }
}
