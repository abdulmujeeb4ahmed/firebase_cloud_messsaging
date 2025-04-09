// android/app/build.gradle.kts

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")  // Apply the Firebase plugin.
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // The namespace is now updated.
    namespace = "com.example.cloudmessaging"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // Update the applicationId to match your new package name.
        applicationId = "com.example.cloudmessaging"
        // Set minSdk to 21, as required for firebase_messaging.
        minSdk = 21
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Signing with debug keys for now so that `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
