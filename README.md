
# Alice Mobile App

## Project Purpose

This repository contains the mobile application for Alice Bakery Shop, a Colombian micro popular company. The app is designed for general marketing exposure, deals, customer assistance, and corporate billing management.

## Requirements

- Flutter SDK: 3.38.5 (stable)
- Dart SDK: >= 3.7.0 < 4.0.0
- Android Studio (latest, with Android SDK tools)
- Java JDK 17 (Amazon Corretto or OpenJDK)
- Gradle 8.11.1+ (handled by gradle-wrapper)
- Xcode (for iOS development, on macOS)

Run the following to check your Flutter environment:
```sh
flutter doctor -v
```

## Setup

1. Install dependencies:
   ```sh
   flutter clean
   flutter pub get
   ```

2. Configure environment:
   - Copy `.env.example` to `.env` and fill in the required values (ask a team member if needed).

3. Add Google service keys:
   - For Android: Place `google-services.json` in `android/app/`.
   - For iOS: Place `GoogleService-Info.plist` in `ios/Runner/`.

4. (Optional) Set up a debug JKS key for Android builds:
   - Generate with:
     ```sh
     keytool -genkey -v -keystore "$HOME/debug-key.jks" -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias debug-key
     ```
   - Update `android/key.properties` with your key path.

5. Update app name and identifiers in:
   - `android/app/src/main/AndroidManifest.xml` (`android:label`)
   - `ios/Runner/Info.plist` (`CFBundleDisplayName`)

## Running the App

- Start an emulator or connect a device (enable developer mode and USB debugging).
- Run:
  ```sh
  flutter run
  ```

## Development Tools

- To update GraphQL schemas, place your schema in `lib/graphql/schema.graphql` and run:
  ```sh
  dart run build_runner build --delete-conflicting-outputs
  ```
- For icons and splash screens, use:
  ```sh
  dart run flutter_native_splash:create
  dart run flutter_launcher_icons:main
  ```

## Getting Started with Flutter

- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)

