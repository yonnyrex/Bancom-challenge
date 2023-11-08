//
//  LoginViewModel.swift
//  Bancom
//
//  Created by Yonny on 7/11/23.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published var login: Login?
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func setUpViewModel(username: String, password: String) {
        login(username: username, password: password)
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

extension LoginViewModel {
    func login(username: String, password: String) {
        
        let headers = ["Content-Type": "application/json",
                       "x-mock-match-request-body" : "true"]
        
        let json: [String: String] = ["username": username,
                                      "password": password
        ]
        
        NetworkManager.shared.genericRequestCustomer(method: .post, baseUrl: "https://6acf21ea-10c1-4221-85c8-9305d6ed8840.mock.pstmn.io", extraPath: "/login", headers: headers, body: json, typeResponse: Login.self)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let err):
                    self?.showAlert(message: err.localizedDescription)
                    break
                default:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.login = response
            })
            .store(in: &cancellable)
    }
}
