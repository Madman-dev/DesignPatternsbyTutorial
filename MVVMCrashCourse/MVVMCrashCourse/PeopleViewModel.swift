//
//  PeopleViewModel.swift
//  MVVMCrashCourse
//
//  Created by Porori on 5/21/24.
//

import Foundation

protocol PeopleViewModelDelegate: AnyObject {
    func didFinish()
    func didFail(error: Error)
}

class PeopleViewModel {
    // we are able to get the info, but does not store any within the ViewModel.
    // limits the view from updating the data after checking for any updates
    private(set) var people: [PersonResponse] = []
    weak var delegate: PeopleViewModelDelegate?
    
    
    // ensures any UI updates are done on Main thread, whereas data fetch will be done background.
    @MainActor
    func getUsers() {
        Task { [weak self] in
            
            do {
                let url = "https://reqres.in/api/users"
                let unwrappedURL = URL(string: url)!
                
                let (data, _) = try await URLSession.shared.data(from: unwrappedURL)
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                self?.people = try jsonDecoder.decode(UsersResponse.self, from: data).data
                self?.delegate?.didFinish()
            } catch {
                print(error)
                self?.delegate?.didFail(error: error)
            }
            
        }
    }
}
