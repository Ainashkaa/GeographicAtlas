# GeographicAtlas
GeographicalAtlas is an iOS application that allows users to effortlessly browse a comprehensive list of countries,
conveniently grouped by regions of the world. With this app, users can quickly access detailed information about any country by navigating to its dedicated details page.
## Features
CountriesList: 
* This page presents users with a scrollable list of all countries worldwide, intelligently grouped by different parts of the world. The app retrieves the country data by making API calls.
* Grouping: The countries are categorized based on the "continents" property obtained from the API response.
* Expandable/Collapsible Elements: Users can toggle between expanded and collapsed states for each country in the list. By default, all list elements are collapsed.
* Seamless Navigation: Tapping on any country in the list will seamlessly transition users to the CountryDetails screen, providing in-depth information  about the selected country. The transition is triggered by tapping the "Learn more" button in the expanded state of a list element.

CountryDetails: This screen displays comprehensive information about the selected country. The app retrieves the detailed data by making an API call to https://restcountries.com/v3.1/alpha/[countryCode/cca2]. The countryCode/cca2 parameter is obtained from the cca2 property of the "Get all countries" API response.
* Detailed Information: Users can view all available data related to the selected country. 
* If the information exceeds the visible screen area, it is made scrollable to ensure a seamless browsing experience.
## Advanced Features
This app includes the following advanced features:

SwiftUI Only: The entire app is developed using SwiftUI, Apple's declarative framework for building user interfaces.
Image Caching: The app implements an image caching mechanism to avoid downloading images multiple times. Once an image is downloaded, it is stored in the cache and reused when needed.
Architecture: The app follows the MVVM (Model-View-ViewModel) architecture pattern. It separates the concerns of data, UI, and business logic to enhance maintainability and testability.
## Demo

https://github.com/Ainashkaa/GeographicAtlas/assets/37531620/0df7546a-ab5a-4978-9c67-865612eef8a2

