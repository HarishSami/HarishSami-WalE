# HarishSami-WalE

The implementation of the APOD (Astronomy Picture of the Day) app has done in SwiftUI, followed by the MVVM design pattern.
NetworkMonitor: Observes network changes and updates the isConnected property accordingly.
ApodView: Checks the network status before calling the API. If the network is disconnected, it loads the cached APOD data.
loadCachedAPOD: A function in APODView to display cached APOD data if no internet is available.
ViewModel: Adjusted to handle caching the APOD data in UserDefaults and loading it when necessary.

Scenarios followed as per Document
1. Display the APOD for the First Time Today (Online)
When the user first arrives at the APOD page and is connected to the internet, fetch the latest APOD from the API, display it, and cache the data.
2. Display Cached APOD When Offline and Already Seen Once Today
If the user has already seen the APOD for today and is offline, display the cached data for that day.
3. Handle Offline Scenario When APOD Not Seen Today
If the user has not seen the APOD today and is offline, display an error message and show the last cached APOD.
4. Ensure the Image Displays Without Distortion or Clipping
The image should be displayed correctly, fitting within the screen without distortion or clipping.

This approach will allow the app to check for network connectivity and handle cases where the device is offline, as per the requirements mentioned in walmart Exercise - MobileApps.pdf file.
