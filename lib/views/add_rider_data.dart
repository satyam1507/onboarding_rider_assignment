import 'package:flutter/material.dart';
import 'package:onboarding_rider_assignment/models/rider.dart';
import 'package:onboarding_rider_assignment/views/add_rider_document.dart';

class AddRiderDataPage extends StatefulWidget {
  AddRiderDataPage({Key? key}) : super(key: key);

  @override
  State<AddRiderDataPage> createState() => _AddRiderDataPageState();
}

class _AddRiderDataPageState extends State<AddRiderDataPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _bankAccountNumberController =
      TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List _locality = ['Rae Bareli', 'Lucknow', 'Kanpur', 'Varanasi'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Rider Data'),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration('Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      decoration: _inputDecoration('Phone Number'),
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 9) {
                          return 'Please enter valid phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  // dropdown for locality

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                        items: _locality
                            .map((value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                        onChanged: (value) {
                          _localityController.text = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid locality';
                          }
                          return null;
                        },
                        decoration: _inputDecoration('Locality')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: _inputDecoration('Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _pinCodeController,
                      decoration: _inputDecoration('Pin Code'),
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 6) {
                          return 'Please enter valid pin code';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _bankAccountNumberController,
                      decoration: _inputDecoration('Bank Account Number'),
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 12) {
                          return 'Please enter valid bank account number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _ifscCodeController,
                      maxLength: 11,
                      decoration: _inputDecoration('IFSC Code'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 11) {
                          return 'Please enter valid IFSC code';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
              Rider rider = Rider(
                uid: DateTime.now().millisecondsSinceEpoch.toString(),
                name: _nameController.text,
                phoneNumber: _phoneNumberController.text,
                address: _addressController.text,
                pinCode: _pinCodeController.text,
                bankAccountNumber: _bankAccountNumberController.text,
                ifscCode: _ifscCodeController.text,
                locality: _localityController.text,
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddRiderDocument(
                            rider: rider,
                          )));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: const Text('Next'),
        ),
      ),
    );
  }
}

// decoration for the text field

InputDecoration _inputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.deepPurple,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
  );
}
