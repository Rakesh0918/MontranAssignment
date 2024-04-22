//
//  PetViewModel.swift
//  MontranAssignment
//
//  Created by Rakesh Sharma on 21/04/24.
//

import Foundation

protocol ReloadView: AnyObject {
    func reloadData()
    func loadSettings(model: Settings)
}

class PetViewModel {
    
    var pets: [Pets] = [] {
        didSet {
            self.reloadView?.reloadData()
        }
    }
    
    private let manager = APIManager()
    weak var reloadView: ReloadView?
    
    func fetchSettingData() {
        Task {
            do {
                let res: ConfigResEntity = try await manager.request(url: userURL)
                reloadView?.loadSettings(model: res.settings)
            }catch {
                print(error)
            }
        }
    }
    
    
    @MainActor func fetchPets() {
        Task {
            do {
                let userResponseArray: [Pets] = try await manager.request(url: userURL)
                self.pets = userResponseArray
            }catch {
                print(error)
            }
        }
    }
    
    @MainActor func loadPetJsonFile(forName: String){
        if let data = manager.readLocalFile(forName: forName) {
            do {
                let decoder = JSONDecoder()
                let res: PetResEntiry = try decoder.decode(PetResEntiry.self, from: data)
                self.pets = res.pets ?? []
            } catch {
                // handle error
                print("failed to json model coversion")
                print(error)
            }
        }
    }
    
    @MainActor func loadConfigJsonFile(forName: String){
        if let data = manager.readLocalFile(forName: forName) {
            do {
                let decoder = JSONDecoder()
                let res: ConfigResEntity = try decoder.decode(ConfigResEntity.self, from: data)
                reloadView?.loadSettings(model: res.settings)
            } catch {
                // handle error
                print("failed to json model coversion")
                print(error)
            }
        }
    }
}
