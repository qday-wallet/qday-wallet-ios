//
//  HomeViewController.swift
//  NBWallet
//
//  Created by Qiyeyun2 on 2024/7/15.
//

import UIKit
import SnapKit
import Web3Auth
import web3
import SafariServices
import Alamofire
import SwiftyJSON
import EmptyDataSet_Swift
import Toast_Swift
import MJRefresh

class HomeViewController: UIViewController {
    //
    var privateKey: String? = ""
    var userInfo: Web3AuthUserInfo?
    var address: EthereumAddress?
    var account: EthereumAccount?
    var txArr:[JSON] = [];
    

    lazy var account_label: UILabel = {
        let v = UILabel()
        v.text = "";
        v.numberOfLines = 1;
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
    lazy var balance_label: UILabel = {
        let v = UILabel()
        v.text = "0 PQUSD";
        v.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        v.numberOfLines = 0;
        return v
    }()
    lazy var balanceRefresh_btn: UIButton = {
        let v = UIButton(type: .custom)
//        v.setTitle("Refresh", for: .normal)
//        v.backgroundColor = UIColor.colorWithHexString(hexString: "#4680ff");
//        v.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        v.setImage(UIImage(named: "refresh"), for: .normal)
//        v.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: -2.5)
//        v.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2.5, bottom: 0, right: 2.5)
//        v.layer.cornerRadius = 5;
//        v.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        v.addTarget(self, action: #selector(balanceRefresh_btnClick), for: .touchUpInside)
        return v
    }()
    lazy var reciver_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.setTitle("Stake", for: .normal)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#4680ff");
        v.setTitle("接收地址", for: .normal)
        v.layer.cornerRadius = 10;
        v.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        v.addTarget(self, action: #selector(reciver_btnClick), for: .touchUpInside)
        return v
    }()
    lazy var transfer_btn: UIButton = {
        let v = UIButton(type: .custom)
        v.backgroundColor = UIColor.colorWithHexString(hexString: "#4680ff");
        v.setTitle("发送交易", for: .normal)
        v.layer.cornerRadius = 10;
        v.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        v.addTarget(self, action: #selector(transfer_btnClick), for: .touchUpInside)
        return v
    }()
    lazy var tableView: UITableView = {
        let v = UITableView(frame: .zero, style: .plain)
        v.dataSource = self;
        v.delegate = self;
        v.separatorStyle = .none
        v.emptyDataSetSource = self;
        v.showsVerticalScrollIndicator = false
        v.register(TXRecordCell.self, forCellReuseIdentifier: "cell")
        v.register(TXRecordTitleHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        if #available(iOS 15.0, *) {
            v.sectionHeaderTopPadding = 0.0
        } else {
            
        }
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white;
        self.navigationItem.title = "Wallet";
        //
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登出", style: .plain, target: self, action: #selector(loginOut_btnClick));
        
        //
        self.setupUI()
        
        //
        self.fetchCurrentState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if let _ = self.address {
            self.refreshUI();
        }
    }
    
    func setupUI() {
        //
        self.view.addSubview(self.account_label);
        self.view.addSubview(self.copy_btn);
        self.view.addSubview(self.balance_label);
        self.view.addSubview(self.balanceRefresh_btn);
        self.view.addSubview(self.reciver_btn);
        self.view.addSubview(self.transfer_btn);
        self.view.addSubview(self.tableView);
        
        //
        self.account_label.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50);
            make.left.equalTo(50)
            make.right.equalTo(self.copy_btn.snp.left).offset(-10);
        }
        self.copy_btn.snp.makeConstraints { make in
            make.right.equalTo(-15);
            make.centerY.equalTo(self.account_label.snp.centerY);
            make.width.height.equalTo(25);
        }
        self.balance_label.snp.makeConstraints { make in
            make.top.equalTo(self.account_label.snp.bottom).offset(20);
            make.centerX.equalTo(self.view.snp.centerX);
        }
        self.balanceRefresh_btn.snp.makeConstraints { make in
            make.left.equalTo(self.balance_label.snp.right).offset(10)
            make.centerY.equalTo(self.balance_label.snp.centerY);
            make.width.height.equalTo(20)
        }
        self.reciver_btn.snp.makeConstraints { make in
            make.top.equalTo(self.balance_label.snp.bottom).offset(50)
            make.right.equalTo(self.view.snp.centerX).offset(-10);
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        self.transfer_btn.snp.makeConstraints { make in
            make.top.equalTo(self.balance_label.snp.bottom).offset(50)
            make.left.equalTo(self.view.snp.centerX).offset(10);
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.reciver_btn.snp.bottom).offset(20);
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-15);
        }
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refrshList));
        
    }
    
    func requestAcount() {
        AF.request(acountAPI,method: .get, parameters: ["address":self.address!.asString()]).validate().responseJSON(completionHandler: { response in
            self.tableView.mj_header?.endRefreshing();
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let balanceStr = json["balance"].string, let balance = Float(balanceStr)  {
                    if balance == 0 {
                        self.balance_label.text = "0" + " PQUSD";
                    } else {
                        self.balance_label.text = String(format: "%2.f", balance/ACCURACY) + " PQUSD";
                    }
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func requestTXList() {
        AF.request(txListAPI,method: .get, parameters: ["address":self.address!.asString()]).validate().responseJSON(completionHandler: { response in
            self.tableView.mj_header?.endRefreshing();
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let list = json.array {
                    self.txArr = list;
                    self.tableView.reloadData();
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func refreshUI() {
        //获取账户信息
        self.requestAcount();
        //
        self.requestTXList();
    }
    
    @objc
    func refrshList() {
        self.refreshUI();
    }
    
    @objc
    func balanceRefresh_btnClick() {
        self.requestAcount();
    }
    
    @objc
    func reciver_btnClick() {
        guard let ads = self.address?.asString() else { return }
        let vc = QRCodeViewController()
        vc.address = ads
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true);
    }
    
    @objc
    func transfer_btnClick() {
        guard let address = self.address else { return }
        guard let privateKey = self.privateKey else { return }
        let vc = TXActionViewController()
        vc.myAddress = address.asString();
        vc.privateKey = privateKey;
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true);
    }
    
    @objc
    func loginOut_btnClick() {
        Task {
            do {
                try await Web3AuthManager.share.web3Auth?.logout()
                let deletate = UIApplication.shared.delegate as? AppDelegate
                let vc = Web3AuthViewController()
                deletate?.window?.rootViewController = vc;
            } catch {
                
            }
        }
    }
    
    @objc
    func copy_btnClick() {
        if let address = self.address?.asString() {
            let pasteboard = UIPasteboard.general;
            pasteboard.string = address;
            self.view.makeToast("copy success");
        }
    }
    
    func fetchCurrentState() {
        Task {
            do {
                if Web3AuthManager.share.web3Auth == nil {
                    try await Web3AuthManager.share.initWeb3Auth()
                }
                guard let state = Web3AuthManager.share.web3AuthState() else {
                    self.login();
                    return
                }
                //
                self.getPrivateKeyAndWalletAress(state: state)
            } catch {
                
            }
        }
    }
    
    func login() {
        let deletate = UIApplication.shared.delegate as? AppDelegate
        let vc = Web3AuthViewController()
        deletate?.window?.rootViewController = vc;
    }
    
    
    
    func getPrivateKeyAndWalletAress(state:Web3AuthState) {
        self.privateKey = Web3AuthManager.share.web3Auth?.getPrivkey();
        do {
            self.account = try EthereumAccount(keyStorage: state as EthereumSingleKeyStorageProtocol)
            self.address = self.account?.address
            self.account_label.text = self.address?.asString();
            if let privateKey = self.privateKey, let address = self.address {
                self.refreshUI()
            }
        } catch {
            
        }
    }

}

extension Web3AuthState: EthereumSingleKeyStorageProtocol {
    public func storePrivateKey(key: Data) throws {
        
    }
    
    public func loadPrivateKey() throws -> Data {
        guard let privKeyData = self.privKey?.web3.hexData else {
            throw SampleAppError.somethingWentWrong
        }
        return privKeyData
        
    }
    
    
}

public enum SampleAppError:Error{
    case noInternetConnection
    case decodingError
    case somethingWentWrong
    case customErr(String)
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.txArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tx = self.txArr[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TXRecordCell;
        cell.backgroundColor = indexPath.row%2 == 0 ? UIColor.colorWithHexString(hexString: "#e6e6e6"): UIColor.white;
        cell.selectionStyle = .none
        if let hash = tx["hash"].string {
            cell.txid_label.text = hash;
        }
        if let to = tx["to"].string {
            cell.toaddress_label.text = to;
        }
        
        if let valueStr = tx["value"].string, let value = Float(valueStr) {
            if value == 0 {
                cell.amount_label.text = "0.00";
            } else {
                let valueStr = String(format: "%2.f", value/ACCURACY);
                var sysmbol = "+";
                if let to = tx["to"].string, let address = self.address?.asString() {
                    if to == address {
                        sysmbol = "+";
                    } else {
                        sysmbol = "-";
                    }
                }
                
                cell.amount_label.text = sysmbol + String(format: "%2.f", value/ACCURACY);
            }
        }
        
        if let status = tx["status"].int {
            if status == 0 {
                cell.status_label.text = "fail";
                cell.status_label.textColor = .red
            } else {
                cell.status_label.text = "success";
                cell.status_label.textColor = UIColor.colorWithHexString(hexString: "#4680ff");
            }
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header");
        return header;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let tx = self.txArr[indexPath.row];
        if let hash = tx["hash"].string {
            let urlStr = txDetailAPI + hash;
            let vc =  SFSafariViewController(url: URL(string: urlStr)!);
            self.present(vc, animated: true)
        }
    }
}

extension HomeViewController: EmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "empty");
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Transaction Empty")
    }
}
