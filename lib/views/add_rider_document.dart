import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onboarding_rider_assignment/models/document.dart';
import 'package:onboarding_rider_assignment/models/rider.dart';
import 'package:onboarding_rider_assignment/state/my_provider_controller.dart';
import 'package:onboarding_rider_assignment/views/homepage.dart';
import 'package:provider/provider.dart';

class AddRiderDocument extends StatefulWidget {
  AddRiderDocument({Key? key, required this.rider}) : super(key: key);

  Rider rider;

  @override
  State<AddRiderDocument> createState() => _AddRiderDocumentState();
}

class _AddRiderDocumentState extends State<AddRiderDocument> {
  Map<String, bool> documents = {
    'Aadhar': false,
    'Pan': false,
    'Driving': false,
    'Bank cheque': false,
    'Photo': false,
  };
  Map<String, bool> documentdata = {
    'Aadhar': false,
    'pan': false,
    'driving': false,
    'bank cheque': false,
    'photo': false,
  };
  List<Document> documentList = [];

  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Rider Documents'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: CheckboxListTile(
                          value: documents.values.elementAt(index),
                          onChanged: (value) {
                            setState(() {
                              documents.update(documents.keys.elementAt(index),
                                  (value) => !value);
                            });
                            print(documents);
                          },
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(documents.keys.elementAt(index)),
                              Row(
                                children: [
                                  documents.values.elementAt(index) == true
                                      ? ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Upload Document'),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            final XFile? image =
                                                                await _picker.pickImage(
                                                                    source: ImageSource
                                                                        .camera);
                                                            if (image != null) {
                                                              setState(() {
                                                                documentList.add(Document(
                                                                    title: documents
                                                                        .keys
                                                                        .elementAt(
                                                                            index),
                                                                    file:
                                                                        image));
                                                              });
                                                              documentdata.update(
                                                                  documents.keys
                                                                      .elementAt(
                                                                          index),
                                                                  (value) =>
                                                                      true);
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Camera'),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            final XFile? image =
                                                                await _picker.pickImage(
                                                                    source: ImageSource
                                                                        .gallery);
                                                            if (image != null) {
                                                              setState(() {
                                                                documentList.add(Document(
                                                                    title: documents
                                                                        .keys
                                                                        .elementAt(
                                                                            index),
                                                                    file:
                                                                        image));
                                                                documentdata.update(
                                                                    documents
                                                                        .keys
                                                                        .elementAt(
                                                                            index),
                                                                    (value) =>
                                                                        true);
                                                              });
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Gallery'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: const Text('Upload'),
                                        )
                                      : ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey),
                                          child: const Text('Upload'),
                                        ),
                                  const SizedBox(width: 5),
                                  documents.values.elementAt(index) == true &&
                                          documentdata[documents.keys
                                                  .elementAt(index)] ==
                                              true
                                      ? ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title:  Text(
                                                        documentList[index].title??''
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Image.file(File(
                                                            documentList[index]
                                                                .file!
                                                                .path))
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: const Text('View'),
                                        )
                                      : ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey),
                                          child: const Text('View'),
                                        ),
                                ],
                              ),
                            ],
                          )),
                    );
                  },
                ),
              ),
              Consumer(builder: (_, addData, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Back'),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          // add rider documents
                          widget.rider.documents = documentList;
                          context
                              .read<MyProviderController>()
                              .addRider(widget.rider);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (route) => false);
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ]),
                );
              }),
            ],
          ),
        ));
  }
}
