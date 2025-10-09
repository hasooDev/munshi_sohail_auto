import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  if (await Permission.storage.request().isGranted) {
    // Granted for Android <= 10
  } else if (await Permission.manageExternalStorage.request().isGranted) {
    // Granted for Android 11+
  } else {
    throw Exception("Storage permission not granted");
  }
}
