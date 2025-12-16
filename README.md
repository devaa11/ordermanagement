# Order Management App

This is a Flutter-based Order Management application that allows users to manage orders with features like login, viewing orders, editing order details, and deleting orders. Firebase is used for authentication and backend services.

---

## Setup Instructions

1. Make sure Flutter is installed on your system.
2. Clone this repository or download the source code.
3. Open the project folder in VS Code or Android Studio.
4. Run the following command to get dependencies:

   flutter pub get

5. Make sure you have a Firebase project created and connected to this app.
    simply create the project and using flutterfire configure with this project and also enable firebase Authentication with email and password sign in method so it will work.

---

## How to Run the App

1. Connect a physical device or start an emulator.
2. Run the app using:

   flutter run

3. The app will launch and show the login screen.
4. After login or signup, you can access the orders dashboard.

---

## Backend Used

- **Firebase**
    - Firebase Authentication for login and registration
    - Firebase used as backend service for managing user sessions

---

## Notes / Assumptions

- User stays logged in using Firebase authentication persistence.
- Internet connection is required for authentication.
- UI is made responsive using `flutter_screenutil`.
- iOS build not included. App tested on Android devices and emulators.


---

