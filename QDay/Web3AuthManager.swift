//
//  Web3AuthManager.swift
//  NBWallet
//
//  Created by Qiyeyun2 on 2024/7/17.
//

import UIKit
import Web3Auth
import web3

class Web3AuthManager {
    
    static let share = Web3AuthManager();
    var web3Auth: Web3Auth?
    
    
    func initWeb3Auth() async throws {
        guard self.web3Auth == nil else {
            return
        }
        web3Auth = await try Web3Auth(.init(clientId: ClientId, network: Network(rawValue: NetworkType)!, redirectUrl: RedirectUrl))
        
    }
    
    func web3AuthState() -> Web3AuthState? {
        guard self.web3Auth != nil else {
            return nil
        }
        return self.web3Auth?.state
    }
    
    func login(provider: Web3AuthProvider) async throws -> Web3AuthState? {
        guard self.web3Auth != nil else {
            return nil
        }
        return try await self.web3Auth?.login(W3ALoginParams(loginProvider: provider))
    }
    
    func login(email: String) async throws -> Web3AuthState? {
        guard self.web3Auth != nil else {
            return nil
        }
        let extraLoginOption = ExtraLoginOptions(display: nil, prompt: nil, max_age: nil, ui_locales: nil, id_token_hint: nil, id_token: nil, login_hint: email, acr_values: nil, scope: nil, audience: nil, connection: nil, domain: nil, client_id: nil, redirect_uri: nil, leeway: nil, verifierIdField: nil, isVerifierIdCaseSensitive: nil, additionalParams: nil)
        return try await self.web3Auth?.login(W3ALoginParams(loginProvider: .EMAIL_PASSWORDLESS, extraLoginOptions: extraLoginOption))
    }
    
    func logout() async throws -> Bool  {
        guard self.web3Auth != nil else {
            return false
        }
        try await self.web3Auth?.logout()
        return true
    }
    
}
