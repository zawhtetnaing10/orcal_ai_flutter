# Oracle-AI Mobile 📱

This is the mobile front-end for the Oracle-AI RAG Personal Assistant. Built with Flutter.

## ✨ Features

Custom Persona Setup: Create an account and tell the AI who you are.

Instant Knowledge Base Sync: Push your professional preferences directly to the backend to build the Knowledge Base.

Smart Chat: Talk to your assistant and get answers based on the knowledge base.

## 🛠 Tech Stack

Flutter: For a cross-platform, high-performance UI.

BLoC Pattern: Keeping the app logic predictable.

Retrofit: Making API calls to our FastAPI backend.

Firebase SDK: Handling Firebase Authentication and Firestore syncing.

## 📸 Screenshots

<img width="336" height="748" alt="SS_Chat" src="https://github.com/user-attachments/assets/41b37ca4-54ae-47d8-b4cc-1000c04f1f3a" />
<img width="336" height="748" alt="SS_BuildKnowledgeBase_1" src="https://github.com/user-attachments/assets/9935d5e7-6813-4aee-a821-7c9480847504" />
<img width="336" height="748" alt="SS_BuildKnowledgeBase_2" src="https://github.com/user-attachments/assets/04bcf4d1-f427-45b4-abb8-0174037638a2" />
<img width="336" height="748" alt="SS_BuildKnowledgeBase_3" src="https://github.com/user-attachments/assets/91cd56c8-33ec-4c6d-aef8-22b5c0b617fb" />
<img width="336" height="748" alt="SS_Login" src="https://github.com/user-attachments/assets/6351e655-8b09-4d85-b32a-41bc045fc791" />
<img width="336" height="748" alt="SS_Register" src="https://github.com/user-attachments/assets/3e32313a-67a5-4eaf-8aa7-de0bf9bacd41" />


## 🚀 Getting Started

### 1. Connection Setup

Make sure your Oracle-AI Backend is running. You'll need to update the baseUrl in the constants.dart to point to your server's IP address (http://10.0.2.2:8080 for android emulator and http://localhost:8080 for iOS simulator).

constants.dart
```
const kBaseUrl = "http://10.0.2.2:8080";
```

### 2. Firebase Configuration (The FlutterFire Way)

This project uses the Firebase CLI for a seamless setup.

Install the FlutterFire CLI:
```
dart pub global activate flutterfire_cli
```

Run the configuration command in the project root and choose your project:
```
flutterfire configure
```

This will automatically register your apps and generate lib/firebase_options.dart.

### 3. Run the App
```
flutter pub get
flutter run
```
