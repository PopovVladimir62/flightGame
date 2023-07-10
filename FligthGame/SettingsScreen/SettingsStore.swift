//
//  SettingsStore.swift
//  FligthGame
//
//  Created by Владимир on 06.07.2023.
//

import Foundation
let store = SettingsStore.shared

import Foundation

public final class SettingsStore {
    
    public static let shared: SettingsStore = .init()
    
    public var gameSettings = Settings(speedRate: 1, enemyVariety: .plane) {
        didSet {
            save()
        }
    }
    
    public var usersSettings: [User] = [] {
        didSet {
            saveUsers()
        }
    }
    
    private lazy var userDefaults: UserDefaults = .standard
    
    private lazy var decoder: JSONDecoder = .init()
    
    private lazy var encoder: JSONEncoder = .init()
    
    
    public func save() {
        do {
            let data = try encoder.encode(gameSettings)
            userDefaults.setValue(data, forKey: "gameSettings")
        }
        catch {
            print("Ошибка кодирования gameSettings для сохранения", error)
        }
    }
    
    public func saveUsers() {
        do {
            let data = try encoder.encode(usersSettings)
            userDefaults.setValue(data, forKey: "usersSettings")
        }
        catch {
            print("Ошибка кодирования usersSettings для сохранения", error)
        }
    }
    
    // MARK: - Private
    
    private init() {

        if let data = userDefaults.data(forKey: "gameSettings") {
            do {
                gameSettings = try decoder.decode(Settings.self, from: data)
            }
            catch {
                print("Ошибка декодирования сохранённых gameSettings", error)
            }
        }
        
        if let usersData = userDefaults.data(forKey: "usersSettings") {
            do {
                usersSettings = try decoder.decode([User].self, from: usersData)
            }
            catch {
                print("Ошибка декодирования сохранённых usersSettings", error)
            }
        }
    }
}
