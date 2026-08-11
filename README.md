# Slanh Pet Application

A cross-platform pet-care mobile application built with Flutter. The current app opens with a branded splash screen and then transitions to the onboarding screen.

## Technologies used

- **Flutter** — cross-platform UI framework for Android, iOS, web, Windows, macOS, and Linux.
- **Dart** — application programming language (SDK `^3.12.1`).
- **Firebase Authentication** — email/password sign-up and sign-in.
- **Cloud Firestore** — stores user profile data.
- **Material Design** — the UI component and theming system.
- **Cupertino Icons** — iOS-style icon set.
- **flutter_lints** and **flutter_test** — code-quality checks and testing tools.

## Prerequisites

Before starting, install the [Flutter SDK](https://docs.flutter.dev/get-started/install) and set up an emulator or physical device. Confirm your environment is ready:

```bash
flutter doctor
```

## Clone and run the project

```bash
git clone https://github.com/ChanthouVouen/g4-slanh-pet-application.git
cd g4-slanh-pet-application
flutter pub get
flutter run
```

To choose a specific connected device, first run `flutter devices`, then use:

```bash
flutter run -d <device-id>
```

## Firebase setup

This app connects to the shared **slanh-pets-app** Firebase project for:

- **Firebase Authentication** — email/password sign-up and sign-in (`lib/core/services/auth/auth_service.dart`)
- **Cloud Firestore** — storing each user's profile in the `users` collection

### Android

The Android config file (`android/app/google-services.json`) is committed in this repo, so **no extra setup is needed** — the regular `flutter pub get` / `flutter run` steps above are enough to connect to Firebase on Android.

### Other platforms (iOS, web, desktop)

Firebase has only been configured for Android so far. To add Firebase support for another platform, install the FlutterFire CLI and generate that platform's config:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

### Firestore security rules

Firestore rules are managed in the Firebase console (not stored in this repo). They must allow a signed-in user to read/write their own document under `users/{uid}`; see Firebase console → Firestore Database → Rules for the live configuration.

## Useful commands

```bash
# Check code quality
flutter analyze

# Run tests
flutter test

# Build an Android APK
flutter build apk
```

## Project structure

```text
slanh_pet_application/
├── assets/
│   └── images/                 # Image assets, including the application logo
├── lib/
│   ├── main.dart               # Application entry point and MaterialApp setup
│   ├── core/
│   │   ├── constants/          # Shared values such as app colors
│   │   └── widgets/            # Reusable UI widgets (logo, circles, indicators)
│   └── features/
│       ├── flash_screen/       # Initial splash-screen feature
│       └── onboarding_screen/  # Onboarding feature
├── test/                       # Widget and unit tests
├── android/                    # Android platform configuration
├── ios/                        # iOS platform configuration
├── web/                        # Web platform configuration
├── windows/                    # Windows platform configuration
├── macos/                      # macOS platform configuration
├── linux/                      # Linux platform configuration
└── pubspec.yaml                # Dependencies, SDK requirement, and asset configuration
```

## Application flow

```text
main.dart
   │
   └── MyApp (MaterialApp)
         │
         └── FlashScreen
               │  Displays the Slanh Pet branding for 3.5 seconds
               │
               └── Fade transition (500 ms)
                     │
                     └── OnbordingScreen
                           └── Displays the onboarding experience
```

`FlashScreen` uses reusable widgets from `lib/core/widgets/` to render the logo and decorative background elements. New screens and business features should be added in `lib/features/`, while shared UI components belong in `lib/core/`.
