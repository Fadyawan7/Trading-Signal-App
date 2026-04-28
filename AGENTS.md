# Repository Guidelines

## Project Structure & Module Organization
This is a Flutter application with platform runners in `android/`, `ios/`, `web/`, `windows/`, `linux/`, and `macos/`. App code lives in `lib/`, with the main entrypoint at `lib/main.dart`. Feature code is organized under `lib/app/features/<feature_name>/` using `views/`, `viewmodel/`, and `bindings/`. Shared routing, theme, widgets, and constants live in `lib/app/routes/`, `lib/app/theme/`, `lib/app/widgets/`, and `lib/app/core/`. Tests belong in `test/`; keep new test files close in name to the feature they cover.

## Build, Test, and Development Commands
Use Flutter CLI from the repository root:

- `flutter pub get` installs dependencies from `pubspec.yaml`.
- `flutter run` launches the app on the selected device or emulator.
- `flutter analyze` runs Dart and Flutter lint checks from `analysis_options.yaml`.
- `flutter test` runs unit and widget tests in `test/`.
- `flutter build apk` or `flutter build web` produces release artifacts for Android or web.

## Coding Style & Naming Conventions
Follow the default `flutter_lints` rules and keep code analyzer-clean before opening a PR. Use 2-space indentation and standard Dart formatting via `dart format .`. Name files in `snake_case.dart`, classes in `PascalCase`, variables and methods in `camelCase`, and routes/constants with descriptive names such as `AppRoutes.login`. Match the existing GetX pattern: `*_view.dart`, `*_view_model.dart`, and `*_binding.dart`.

## Testing Guidelines
Use `flutter_test` for widget and unit coverage. Name tests with the `_test.dart` suffix, for example `home_view_test.dart`. Prefer behavior-focused test names like `testWidgets('App boots to login route', ...)`. Add or update tests for new routes, view models, and reusable widgets before merging.

## Commit & Pull Request Guidelines
The current history is minimal (`first commit`, `cod`), so use a stricter standard going forward: short, imperative commit messages such as `Add trader profile route`. Keep commits focused on one change. PRs should include a clear summary, testing notes (`flutter analyze`, `flutter test`), linked issues when applicable, and screenshots or recordings for UI changes.

## Configuration Notes
Do not commit generated build output from `build/` or secrets. When adding assets or fonts, register them explicitly in `pubspec.yaml` before use.
