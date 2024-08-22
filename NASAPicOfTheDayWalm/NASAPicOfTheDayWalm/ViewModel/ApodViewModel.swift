//
//  ApodViewModel.swift
//  NASAPicOfTheDayWalm
//
//  Created by Harish Sami on 21/08/24.
//

import Foundation
import Combine

class ApodViewModel: ObservableObject {
    @Published var apod: APOD?
    @Published var errorMessage: String?
    var cachedAPOD: APOD?

    private var cancellables = Set<AnyCancellable>()
    private let userDefaults = UserDefaults.standard
    private let apiKey = "ySHXyaj01mT7EOyBIIl0waOaLt8ZVFZPqFR3vpoi"
    private let baseURL = "https://api.nasa.gov/planetary/apod"
    
    var hasSeenAPODToday: Bool {
        if let lastFetchDate = userDefaults.object(forKey: "lastFetchDate") as? Date {
            return Calendar.current.isDateInToday(lastFetchDate)
        }
        return false
    }

    func fetchAPOD() {
        guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)") else {
            self.errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APOD.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { apod in
                self.apod = apod
                self.cacheAPOD(apod)
            })
            .store(in: &cancellables)
    }

    private func cacheAPOD(_ apod: APOD) {
        if let data = try? JSONEncoder().encode(apod) {
            userDefaults.set(data, forKey: "cachedAPOD")
            userDefaults.set(Date(), forKey: "lastFetchDate")
        }
    }

    func loadCachedAPOD() {
        if let data = userDefaults.data(forKey: "cachedAPOD"),
           let cachedAPOD = try? JSONDecoder().decode(APOD.self, from: data) {
            self.cachedAPOD = cachedAPOD
        }
    }
}

