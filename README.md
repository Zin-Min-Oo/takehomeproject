# 📱 TakeHomeProject

A **Flutter 3.24.4** application following the **MVC Architecture**, featuring **BLoC State Management**, **Shared Preferences for local storage**, and **Internet connectivity checking**. This app is designed to efficiently manage user data, posts, authentication, and network monitoring.

---

## 📌 **Project Overview**
This app includes:
- ✅ **User List**: Displays users fetched from an API and stored in SharedPreferences.
- ✅ **Post List**: Fetches posts and supports searching and filtering.
- ✅ **User Profile**: Displays user details with logout functionality.
- ✅ **Login & Signup Pages**: Firebase Authentication integration.
- ✅ **Internet Connection Monitoring**: Detects real-time network status.

---

## 📂 **Project Structure**
```
lib/
│── controllers/
│   ├── blocs/           # BLoC State Management for Users & Posts
│   ├── services/        # API Services (User & Post Fetching, Authentication)
│
│── models/              # Data Models (User, Post, Address, etc.)
│
│── views/               # UI Views (Pages & Widgets)
│   ├── pages/           # Screens (Login, Signup, Profile, User List, Post List)
│   ├── widgets/         # Reusable UI components
│
│── main.dart            # Entry Point of the Application
```

---

## 🚀 **Technology Stack**
| Technology          | Version    |
|---------------------|-----------|
| **Flutter**        | 3.24.4     |
| **Dart**           | 3.5.4      |
| **BLoC**           | ✅ Yes     |
| **Shared Preferences** | ✅ Yes |
| **Firebase Auth**  | ✅ Yes     |
| **Connectivity Plus** | ✅ Yes |
| **Dio**            | ✅ Yes     |

---

## 📦 **Dependencies**
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  firebase_core: any
  cloud_firestore: ^4.8.2
  firebase_auth: ^4.6.3
  firebase_storage: ^11.2.4
  fluttertoast: ^8.2.2
  font_awesome_flutter: ^10.6.0
  google_sign_in: ^6.1.5
  connectivity_plus: ^5.0.2
  dio: ^5.4.0
  shared_preferences: ^2.2.2
  equatable:
  flutter_bloc: ^8.1.3
  flutter_spinkit:
```

---

## 🔹 **How to Run the Project**
### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/your-repo/takehomeproject.git
cd takehomeproject
```

### **2️⃣ Install Dependencies**
```sh
flutter pub get
```

### **3️⃣ Run the App**
```sh
flutter run
```

---

## 🔐 **Authentication (Login/Signup)**
- Uses **Firebase Authentication**.
- Supports **email/password-based sign-in**.
- After login, users are redirected to the **HomePage**.

---

## 🌐 **Internet Connectivity Checking**
- Uses **`connectivity_plus`** to detect **WiFi & Mobile Data**.
- Shows a **toast notification** when the internet is lost or restored.
- Displays a **red warning banner** when offline.

---

## 🛠️ **Build & Release**
### **🔹 Generate Release APK**
```sh
flutter build apk --release
```

### **🔹 Generate App Bundle (.AAB) for Play Store**
```sh
flutter build appbundle
```

### **🔹 Signing the APK (if required)**
If deploying to the Google Play Store, sign the APK with a **keystore**.

1️⃣ **Generate a Keystore**:
```sh
keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2️⃣ **Configure `android/keystore.properties`**:
```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=upload
storeFile=upload-keystore.jks
```

3️⃣ **Update `android/app/build.gradle`**:
```gradle
signingConfigs {
    release {
        storeFile file("../upload-keystore.jks")
        storePassword project.property("storePassword")
        keyAlias project.property("keyAlias")
        keyPassword project.property("keyPassword")
    }
}
```

4️⃣ **Build the Signed APK**:
```sh
flutter build apk --release
```

---

## 📝 **License**
This project is licensed under the **MIT License**.

---

## 💡 **Contributing**
Want to improve this project? Contributions are always welcome! 🚀

1. Fork the repository.
2. Create a new branch.
3. Commit your changes.
4. Submit a Pull Request.

---

📌 **Developed with ❤️ using Flutter**  🚀

