# Student Management System — Flutter (Week 8 Final Project)

A clean, modular, responsive Student Management System that runs on
**Android, iOS, Web, Windows, macOS, and Linux** from a single codebase.

## Folder Structure

```
student_management_system/
├── pubspec.yaml
└── lib/
    ├── main.dart                      # App entry point, providers, theme, AuthGate
    ├── models/
    │   └── student.dart                # Student data model (toJson/fromJson)
    ├── services/
    │   ├── storage_service.dart        # shared_preferences persistence
    │   └── auth_service.dart           # Login/session persistence
    ├── providers/
    │   ├── auth_provider.dart          # Auth/session state (ChangeNotifier)
    │   └── student_provider.dart       # Student CRUD + search state
    ├── utils/
    │   ├── constants.dart              # Colors, spacing, responsive breakpoints
    │   └── validators.dart             # Form validation rules
    ├── widgets/
    │   ├── custom_text_field.dart
    │   ├── custom_button.dart
    │   ├── student_card.dart
    │   └── empty_state.dart
    └── screens/
        ├── login_screen.dart
        ├── dashboard_screen.dart
        ├── student_list_screen.dart
        └── add_edit_student_screen.dart
```

**Layers, and who talks to whom:**
`Screens (UI)` → `Providers (business logic / state)` → `Services (storage & auth)` → `Models (data)`
Screens never touch `SharedPreferences` directly — everything flows through `AuthProvider` / `StudentProvider`.

## Setup Instructions

This project ships as `lib/` + `pubspec.yaml` only. Flutter needs to
generate the native platform folders (`android/`, `ios/`, `web/`,
`windows/`, `macos/`, `linux/`) for your machine/SDK version, so:

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.3+) and run `flutter doctor` to confirm your setup.
2. Create a new Flutter project shell, then drop this code in:
   ```bash
   flutter create student_management_system
   cd student_management_system
   # Replace the generated lib/ and pubspec.yaml with the ones from this project
   ```
   (Or: copy `lib/` and `pubspec.yaml` from this download into an existing
   `flutter create .`-scaffolded folder.)
3. Enable the platforms you want (desktop/web are off by default on older SDKs):
   ```bash
   flutter config --enable-windows-desktop --enable-macos-desktop --enable-linux-desktop
   ```
4. Install dependencies:
   ```bash
   flutter pub get
   ```
5. Run:
   ```bash
   flutter run -d chrome     # Web
   flutter run -d windows    # Windows desktop
   flutter run -d macos      # macOS desktop
   flutter run               # Connected Android/iOS device or emulator
   ```

## Demo Login

- **Email:** `admin@school.com`
- **Password:** `admin123`

(This is a local, backend-free demo login — see the comment in
`auth_service.dart` for how to swap in real authentication later.)

## Key Dependencies (`pubspec.yaml`)

| Package | Purpose |
|---|---|
| `provider` | State management, connects Providers to Screens |
| `shared_preferences` | Local persistent storage — works on mobile, web, and desktop |
| `uuid` | Generates unique IDs for new student records |

## Responsiveness Notes

- `utils/constants.dart` defines `Breakpoints` (mobile < 600, tablet < 1024, desktop ≥ 1024).
- Forms and lists are wrapped in a `ConstrainedBox` with `Breakpoints.contentMaxWidth()` so they don't stretch edge-to-edge on wide/web screens.
- The Dashboard's quick-action grid adapts from 1 column (mobile) → 2 (tablet) → 3 (desktop).
- The Student List switches from a single-column list (mobile) to a 2-column grid (wide screens ≥ 700px) automatically via `LayoutBuilder`.

## Extending Storage to SQLite/Hive

Only `services/storage_service.dart` needs to change — its public
method signatures (`loadStudents`, `saveStudents`) are what the rest
of the app depends on, so switching the backing store is a one-file change.
