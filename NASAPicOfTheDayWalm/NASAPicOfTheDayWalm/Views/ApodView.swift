//
//  ApodView.swift
//  NASAPicOfTheDayWalm
//
//  Created by Harish Sami on 21/08/24.
//

import SwiftUI

struct ApodView: View {
    @ObservedObject var viewModel = ApodViewModel()
    @ObservedObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationView {
            VStack {
                if !networkMonitor.isConnected {
                    if viewModel.hasSeenAPODToday {
                        loadCachedAPOD()
                    } else {
                        Text("We are not connected to the internet, showing you the last image we have.")
                            .foregroundColor(.red)
                            .padding()
                        loadCachedAPOD()
                    }
                } else if let apod = viewModel.apod {
                    ScrollView {
                        VStack(spacing: 16) {
                            Text(apod.title)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .font(.title)
                                .foregroundColor(Color.purple)
                                .padding(.bottom, 10)
                            RemoteImageView(urlString: apod.url)
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            
                            Text(apod.explanation)
                                .font(.body)
                                .foregroundColor(Color.black)
                                .padding(.horizontal)
                                .multilineTextAlignment(.leading)
                        }
                        .cornerRadius(10)
                        .padding(.horizontal)
                        Spacer()
                    }
                    .background(Color.white.edgesIgnoringSafeArea(.all))
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
            .navigationTitle("APOD")
            .onAppear {
                if networkMonitor.isConnected {
                    viewModel.fetchAPOD()
                } else {
                    viewModel.loadCachedAPOD()
                }
            }
        }
    }
    
    private func loadCachedAPOD() -> some View {
        VStack(spacing: 16) {
            if let cachedAPOD = viewModel.cachedAPOD {
                ScrollView {
                Text(cachedAPOD.title)
                    .font(.title)
                    .foregroundColor(Color.purple)
                    .padding(.bottom, 10)
                
                RemoteImageView(urlString: cachedAPOD.url)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                    Text(cachedAPOD.explanation)
                        .font(.body)
                        .foregroundColor(Color.white)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                }
                .background(Color.black)
                .cornerRadius(10)
                .padding(.horizontal)
            } else {
                Text("No cached image available.")
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ApodView()
}
