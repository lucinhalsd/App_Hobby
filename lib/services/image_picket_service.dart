import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<String?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image?.path;
  }
}

class ImagePicker {
  Future<XFile?> pickImage({required ImageSource source}) async {
    // Simulate image picking
    await Future.delayed(Duration(seconds: 1));
    return XFile('/path/to/selected/image.png');
  }
}

class ImageSource {
  static const gallery = ImageSource._internal();
  const ImageSource._internal();
}

class   XFile {
  final String path;
  XFile(this.path);
}
