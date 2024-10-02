# 2024-Autumn-Aberdeen-8-LifePulse

## Overview
LifePulse is a mobile blood testing system designed to provide intelligent identification and analysis of blood cells using deep learning technology. The app offers convenient at-home sample collection and quick health reports, improving healthcare efficiency while ensuring user data privacy. It is developed using Kotlin and Android Studio.

## Features
- **Intelligent Blood Testing:** Utilizes the YOLOv5 algorithm for fast, automated blood cell recognition and analysis.
- **At-Home Sample Collection:** Allows users to collect blood samples at home and submit them via their mobile device.
- **Personalized Health Reports:** Provides customized health insights based on user medical history and test results.
- **Data Security:** Implements advanced encryption to protect sensitive health data.

## Project Structure
The project follows Android best practices using Kotlin, with a clean architecture approach.

```
- app/
  - src/
    - main/
      - java/com/lifepulse/
        - ui/         # User Interface components
        - model/      # Data models and business logic
        - repository/ # Data handling and API communication
        - viewmodel/  # ViewModels for managing UI-related data
      - res/
        - layout/     # XML layout files
        - values/     # Strings, colors, and other resources
      - assets/       # Any additional resources like sample data or files
  - build.gradle      # Gradle configuration
  - AndroidManifest.xml  # App permissions and activity declarations
```

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/your-repo/lifepulse-app.git
   ```
2. Open the project in Android Studio.
3. Ensure you have the latest Kotlin and Android SDK installed.
4. Build and run the app on an Android emulator or a physical device.

## Tech Stack
- **Programming Language:** Kotlin
- **Development Platform:** Android Studio
- **Algorithm:** YOLOv5 (for blood cell identification)
- **Architecture:** MVVM (Model-View-ViewModel)
- **Libraries:**
  - Retrofit (for network requests)
  - Room (for local database storage)
  - LiveData and ViewModel (for UI data handling)
  - Glide (for image loading)

## Future Enhancements
- Integration with wearable health devices for real-time data monitoring.
- Expansion of AI-based analytics for more detailed health assessments.
- Localization for multiple languages.
  
