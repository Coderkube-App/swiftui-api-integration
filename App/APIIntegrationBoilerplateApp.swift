//
// Copyright (c) 2026 Coderkube Technologies - APIIntegrationBoilerplateApp. All rights reserved.
//

import SwiftUI

@main
struct APIIntegrationBoilerplateApp: App {
  private let diContainer = DIContainer()
  @StateObject private var coordinator: AppCoordinator
  
  init() {
    _coordinator = StateObject(wrappedValue: AppCoordinator(diContainer: DIContainer()))
  }
  
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $coordinator.navigationPath) {
        coordinator.start()
      }
    }
  }
}
