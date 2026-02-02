import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile> compressImageFile({
  required File imageFile,
  int maxSizeInMB = 2,
  CompressFormat format = CompressFormat.jpeg,
}) async {
  int quality = 90;
  XFile? compressedFile;

  while (quality >= 10) {
    final targetPath = path.join(
      Directory.systemTemp.path,
      'img_${DateTime.now().millisecondsSinceEpoch}.${format.name}',
    );

    compressedFile = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      targetPath,
      quality: quality,
      format: format,
    );

    if (compressedFile == null) {
      throw "Image compression failed!";
    }

    final int sizeInBytes = await compressedFile.length();
    final double sizeInMB = sizeInBytes / (1024 * 1024);

    debugPrint("Quality: $quality → Size: ${sizeInMB.toStringAsFixed(2)} MB");

    if (sizeInMB <= maxSizeInMB) {
      return compressedFile;
    }

    quality -= 10; // reduce quality and try again
  }

  throw "Unable to compress image below ${maxSizeInMB}MB";
}
