# CytoGenesis

Cytoid Charter App written in Flutter Framework.

## Getting Started

# Developer Dependencies

1. Flutter (duh!)
2. Android-SDK version 28 (Easiest to install via Android Studio). Latest Android Studio install
   Andoird-SDK may only install version 29 upwards. If you get error running depite `flutter doctor` does
   not spew errors on Android-SDK do next step in Terminal:
   ```bash
   cp $HOME/Android/Sdk/platforms/android-29/android.jar $HOME/Android/Sdk/platforms/android-28/android.jar
   ```

# How to Run (Dev)

Connect your phone (and make sure `USB Debugging` in `developer option` is ticked).

Run in Terminal:

```bash
flutter devices
```

You should get your phone device id on the output. Then run:

```bash
flutter run -d "device_id"
```
