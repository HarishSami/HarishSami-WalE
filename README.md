# HarishSami-WalE

The implementation of the APOD (Astronomy Picture of the Day) app has done in SwiftUI, followed by the MVVM design pattern.
NetworkMonitor: Observes network changes and updates the isConnected property accordingly.
ApodView: Checks the network status before calling the API. If the network is disconnected, it loads the cached APOD data.
loadCachedAPOD: A function in APODView to display cached APOD data if no internet is available.
ViewModel: Adjusted to handle caching the APOD data in UserDefaults and loading it when necessary.

This approach will allow the app to check for network connectivity and handle cases where the device is offline, as per the requirements mentioned in walmart Exercise - MobileApps.pdf file.
