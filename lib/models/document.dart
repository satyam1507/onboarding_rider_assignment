import 'package:image_picker/image_picker.dart';

class Document {
  String? title;
  XFile? file;

  Document({
    required this.title,
    required this.file,
  });
}
