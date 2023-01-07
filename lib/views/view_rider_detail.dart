import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_rider_assignment/models/rider.dart';
import 'package:onboarding_rider_assignment/state/my_provider_controller.dart';
import 'package:provider/provider.dart';

class ViewRiderDetail extends StatefulWidget {
  ViewRiderDetail({Key? key, required this.rider}) : super(key: key);

  Rider rider;
  @override
  State<ViewRiderDetail> createState() => _ViewRiderDetailState();
}

class _ViewRiderDetailState extends State<ViewRiderDetail> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.rider.documents!
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.file(File(item.file!.path),
                          fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            ' ${item.title}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rider Detail'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 2,
                    autoPlay: true,
                  ),
                  items: imageSliders,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _richText('Name: ', widget.rider.name!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _richText('PhoneNo: ', widget.rider.phoneNumber!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _richText('Address: ', widget.rider.address!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _richText('Locality: ', widget.rider.locality!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _richText('Pinrcode: ', widget.rider.pinCode!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _richText(
                      'Status: ',
                      widget.rider.status == 0
                          ? 'Pending'
                          : widget.rider.status == 1
                              ? 'Approved'
                              : 'Rejected'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Consumer(builder: (context, watch, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<MyProviderController>()
                          .acceptRider(widget.rider);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Approve'),
                  )),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<MyProviderController>()
                          .rejectRider(widget.rider);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Reject'),
                  )),
            ],
          );
        }));
  }
}

RichText _richText(String text, String value) {
  return RichText(
    text: TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      children: <TextSpan>[
        TextSpan(
          text: value,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
      ],
    ),
  );
}
