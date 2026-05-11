# Trading Signal App - Gemini Project Context

This document provides essential context and instructions for AI agents working on the Trading Signal App.

## Project Overview
A Flutter application designed as a marketplace for trading groups and signals. It features a robust, feature-based architecture powered by **GetX** for state management, dependency injection, and routing.

- **Main Technologies:** Flutter, GetX, HTTP, Shared Preferences, Google Fonts.
- **Key Features:** User/Trader roles, group discovery, premium subscriptions, group chats, and trader dashboards.

## Architecture & Structure
The project follows a modular, feature-oriented structure in the `lib/` directory:

- `lib/main.dart`: Entry point, initializes core services (Theme, Connectivity, Session).
- `lib/app/features/`: Contains feature modules. Each module typically includes:
    - `bindings/`: GetX dependencies registration.
    - `viewmodel/`: Business logic and state (extending `BaseViewModel`).
    - `views/`: UI components (using `GetView<ViewModel>`).
- `lib/app/core/`: Shared core logic:
    - `base/`: Base classes like `BaseViewModel`.
    - `services/`: Global services (e.g., `SessionService`, `ConnectivityService`).
    - `network/`: Networking infrastructure.
    - `utils/`: Reusable utility functions.
- `lib/app/routes/`: Navigation definitions (`app_pages.dart`, `app_routes.dart`).
- `lib/app/theme/`: Visual styling and theme management.
- `lib/app/widgets/`: Global reusable UI components.

## Development & Build Commands
Standard Flutter CLI commands are used:

- **Install dependencies:** `flutter pub get`
- **Run the app:** `flutter run`
- **Run tests:** `flutter test`
- **Linting:** `flutter analyze`
- **Format code:** `dart format .`
- **Generate features:** `./gen_features.sh` (Script for scaffolding new feature modules).

## Development Conventions
- **Naming:** 
    - Files: `snake_case.dart`
    - Classes: `PascalCase`
    - Variables/Methods: `camelCase`
    - Feature files: `*_view.dart`, `*_view_model.dart`, `*_binding.dart`.
- **State Management:** Use GetX (`Obx`, `Rx` variables).
- **Base Classes:** All ViewModels should extend `BaseViewModel` to leverage shared loading, connectivity, and feedback logic.
- **Guidelines:** Refer to `AGENTS.md` for detailed repository guidelines, including testing and PR standards.

## Key Files for Reference
- `pubspec.yaml`: Dependencies and assets configuration.
- `AGENTS.md`: Comprehensive development and contribution guidelines.
- `gen_features.sh`: Shell script defining the standard feature structure.
- `lib/app/core/base/base_view_model.dart`: Core logic for all view models.
- `lib/app/routes/app_routes.dart`: Enumeration of all application routes.
