import 'package:flutter/cupertino.dart';
import 'package:onboarding_rider_assignment/models/rider.dart';

class MyProviderController extends ChangeNotifier {
  List<Rider> riders = [];

  void addRider(Rider rider) {
    // add rider to the list with uid aas timestamp
    riders.add(rider);
    notifyListeners();
  }

  void rejectRider(Rider rider) {
    // change status to 2 and  edit the riders list
    for (var element in riders) {
      if (element.uid == rider.uid) {
        element.status = -1;
      }
    }
    notifyListeners();
  }

  void acceptRider(Rider rider) {
    // change status to 1 and  edit the riders list
    for (var element in riders) {
      if (element.uid == rider.uid) {
        element.status = 1;
      }
    }
    notifyListeners();
  }

  void deleteRider(Rider rider) {
    // delete the rider from the list
    riders.remove(rider);
    notifyListeners();
  }
}
