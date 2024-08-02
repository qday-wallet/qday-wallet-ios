//
//  Config.swift
//  NBWallet
//
//  qday on 2024/7/17.
//

import UIKit

/**
 web3Auth
 */
//dev
let ClientId = "xxx";
let NetworkType = "sapphire_devnet";
let RedirectUrl = "top.xy.QDay://auth";

//pro
//let ClientId = "";
//let Network = "";
//let RedirectUrl = "";

/**
 Server
 */
//domain
let server = "http://159.138.123.40:4000";
//query account
let acountAPI = server + "/account";
//encrypt Tx
let encryptTXAPI = server + "/encryptTx";
//TX List
let txListAPI = server + "/tx";

//tx detail server
let txDetailAPI = "http://124.243.133.105/tx/"


/**
 Contract
 */

let ACCURACY:Float = 1e18;





