import 'document.dart';

class Rider {
  String uid;
  String? name;
  String? phoneNumber;
  String? address;
  String? pinCode;
  String? bankAccountNumber;
  String? ifscCode;
  String? locality;
  List<Document>? documents = [];
  int status = 0;

  Rider({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.pinCode,
    required this.bankAccountNumber,
    required this.ifscCode,
    required this.locality,
  });
}
