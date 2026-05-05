# Movie App (iOS / SwiftUI)

A simple and scalable iOS application to browse movie details using The Movie Database (TMDB) API. This project follows a clean architecture approach with a generic network layer using URLSession.

## Features

- Fetch and display movie details
- Scalable API integration using URLSession abstractions
- Clean Architecture + MVVM and modular project structure
- Pagination support for movie lists
- Centralized API handling and Dependency Injection
- Optimized network calls with error handling

## Project Structure

```
ios-swiftui-api-integration-boilerplate/
│
├── App/                  # App Entry Point & Lifecycle
├── Core/                 # Network layer abstractions, Constants, and Utilities
├── DI/                   # Dependency Injection Container (API keys configuration)
├── Data/                 # Remote Data Sources, Repositories mapping API responses
├── Domain/               # Business rules, Entities, and UseCases for API operations
├── Presentation/         # UI Components, ViewModels handling API states (loading/error/success)
├── Resources/            # Assets, fonts, and colors
└── Tests/                # Unit tests including API mocking
```

## API Key Setup (IMPORTANT)

This project uses TMDB API.

You must add your own API key before running the project.
**Steps:**

1. Create an account on TMDB
2. Generate your API key
3. Open the file:
   `DI/DIContainer.swift`
4. Add your API key:

```swift
@MainActor
public class DIContainer {
  
  // Configurable API URL and Key
  private let apiBaseURL = "https://api.themoviedb.org/3"
  private let apiKey = "YOUR_API_KEY_HERE"
  
  // ...
}
```

## Getting Started

1. **Clone the repository**

```bash
git clone https://github.com/Coderkube-App/swiftui-api-integration.git
```

2. **Generate Xcode Project**
Ensure XcodeGen is installed (`brew install xcodegen`).

```bash
xcodegen generate
```

3. **Open the project**
Open the generated `ios-swiftui-api-integration-boilerplate.xcodeproj`.

4. **Run the app**
Select your target simulator/device and run the scheme (Cmd+R).

## Tech Stack

- Swift
- SwiftUI
- URLSession (HTTP client)
- XcodeGen

## Notes

- Do not commit your API key to public repositories
- If API calls fail, check:
  - Internet connection
  - API key validity
  - Rate limits

## Best Practices Used

- Centralized Dependency Injection
- Separation of concerns (Clean Architecture: Domain, Data, Presentation)
- Repository Pattern
- Reusable network layer with typed errors

## Future Improvements

- Search movies
- Favorites or Watchlist
- Movie trailers
- Dark mode support

## Contribution

- Feel free to fork and improve this project
- Pull requests are welcome
