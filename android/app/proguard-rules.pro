# Flutter-specific rules
-keep class io.flutter.** { *; }
-keep class com.example.jet_set_go.** { *; }

# Firebase-specific rules (if using Firebase)
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Ensure reflection-based code is not removed
-keepattributes *Annotation*
-dontwarn android.support.**
-dontwarn com.google.**
