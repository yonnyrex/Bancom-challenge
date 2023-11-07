//
//  MainViewModel.swift
//  Bancom
//
//  Created by Yonny on 7/11/23.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published var listUsers: [User] = []
    @Published var listPosts: [Post] = []
    @Published var showAlert = false
    @Published var alertMessage = ""

    func setUpViewModel() {
        if listUsers.isEmpty {
            getUsers()
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}


extension MainViewModel {
    func getUsers() {
        
        listUsers.removeAll()

        NetworkManager.shared.genericRequestCustomer(baseUrl: "https://jsonplaceholder.typicode.com/users", typeResponse: [User].self)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let err):
                    self?.showAlert(message: err.localizedDescription)
                    break
                default:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.listUsers = response
            })
            .store(in: &cancellable)
    }
    
    func getPosts(userID: Int) {
        
        listPosts.removeAll()
        
        let extraPath = "/\(userID)/posts"

        NetworkManager.shared.genericRequestCustomer(baseUrl: "https://jsonplaceholder.typicode.com/users", extraPath: extraPath , typeResponse: [Post].self)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let err):
                    self?.showAlert(message: err.localizedDescription)
                    break
                default:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.listPosts = response
            })
            .store(in: &cancellable)
    }
}
