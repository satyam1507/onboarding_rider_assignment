import 'package:flutter/material.dart';
import 'package:onboarding_rider_assignment/state/my_provider_controller.dart';
import 'package:onboarding_rider_assignment/views/add_rider_data.dart';
import 'package:onboarding_rider_assignment/views/view_rider_detail.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riders'),
      ),
      body: Consumer<MyProviderController>(builder: (_, homepage, child) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: context.watch<MyProviderController>().riders.length,
              itemBuilder: (context, index) {
                var rider = context.watch<MyProviderController>().riders[index];
                return Dismissible(
                  key: Key(rider.name!),
                  background: Container(
                    color: Colors.green,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      context.read<MyProviderController>().acceptRider(rider);
                      return false;
                    } else {
                      context.read<MyProviderController>().rejectRider(rider);
                      return false;
                    }
                  },
                  onDismissed: (_) {
                    setState(() {
                      context.read<MyProviderController>().riders.remove(rider);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(rider.name!),
                      subtitle: Text(rider.phoneNumber.toString()),
                      trailing: rider.status == 1
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                Text('Accepted'),
                              ],
                            )
                          : rider.status == -1
                              ? Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                    Text('Rejected'),
                                  ],
                                )
                              : Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.pending,
                                      color: Colors.yellow,
                                    ),
                                    Text('Pending'),
                                  ],
                                ),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewRiderDetail(rider: rider),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
      floatingActionButton: SizedBox(
        width: 150,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddRiderDataPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: const Text('Add Rider'),
        ),
      ),
    );
  }
}
