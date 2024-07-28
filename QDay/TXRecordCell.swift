//
//  TXRecordCell.swift
//  NBWallet
//
//  Created by 621design on 2024/7/26.
//

import UIKit

class TXRecordCell: UITableViewCell {
    
    lazy var txid_label: UILabel = {
        let v = UILabel()
        v.text = "";
        v.textAlignment = .center
        v.lineBreakMode = .byTruncatingMiddle;
        v.font = UIFont.systemFont(ofSize: 15)
        return v
    }()
    
    lazy var toaddress_label: UILabel = {
        let v = UILabel()
        v.text = "";
        v.textAlignment = .center
        v.lineBreakMode = .byTruncatingMiddle;
        v.font = UIFont.systemFont(ofSize: 15)
        return v
    }()
    
    lazy var amount_label: UILabel = {
        let v = UILabel()
        v.text = "";
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 15)
        return v
    }()
    
    lazy var status_label: UILabel = {
        let v = UILabel()
        v.text = "";
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 15)
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //
        self.contentView.addSubview(self.txid_label);
        self.contentView.addSubview(self.toaddress_label);
        self.contentView.addSubview(self.amount_label);
        self.contentView.addSubview(self.status_label);
        
        //
        let itemW = (UIScreen.main.bounds.width - 5*5 - 15*2)/4.0;
        self.txid_label.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.left.equalTo(5)
            make.width.equalTo(itemW)
        }
        self.toaddress_label.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.txid_label.snp.right).offset(5)
            make.width.equalTo(itemW)
        }
        self.amount_label.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.toaddress_label.snp.right).offset(5)
            make.width.equalTo(itemW)
        }
        self.status_label.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.amount_label.snp.right).offset(5)
            make.width.equalTo(itemW)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
