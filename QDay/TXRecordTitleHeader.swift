//
//  TXRecordTitleHeader.swift
//  NBWallet
//
//  qday on 2024/7/26.
//

import UIKit
import SnapKit

class TXRecordTitleHeader: UITableViewHeaderFooterView {
    
    lazy var txid_label: UILabel = {
        let v = UILabel()
        v.text = "txid";
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return v
    }()
    
    lazy var toaddress_label: UILabel = {
        let v = UILabel()
        v.text = "to address";
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return v
    }()
    
    lazy var amount_label: UILabel = {
        let v = UILabel()
        v.text = "amount";
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return v
    }()
    
    lazy var status_label: UILabel = {
        let v = UILabel()
        v.text = "status";
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return v
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        //
        self.contentView.addSubview(self.txid_label);
        self.contentView.addSubview(self.toaddress_label);
        self.contentView.addSubview(self.amount_label);
        self.contentView.addSubview(self.status_label);
        
        //
        self.txid_label.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.left.equalTo(0)
            make.width.equalTo(self.contentView.snp.width).multipliedBy(1/4.0)
        }
        self.toaddress_label.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.txid_label.snp.right)
            make.width.equalTo(self.contentView.snp.width).multipliedBy(1/4.0)
        }
        self.amount_label.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.toaddress_label.snp.right)
            make.width.equalTo(self.contentView.snp.width).multipliedBy(1/4.0)
        }
        self.status_label.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.toaddress_label.snp.right)
            make.right.equalTo(0)
            make.width.equalTo(self.contentView.snp.width).multipliedBy(1/4.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
