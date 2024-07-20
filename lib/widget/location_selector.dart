import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:map/data/locationdatas.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  Location? _pickedlocation;
  bool _isgettinglocation = false;

  void _getloaction() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isgettinglocation = true;
    });
    _locationData = await location.getLocation();
    setState(() {
      _isgettinglocation = false;
    });
    print(_locationData.latitude);
    print(_locationData.longitude);
  }

  Widget ourcontent = const Text('No Location Choosen yet');

  @override
  Widget build(BuildContext context) {
    if (_isgettinglocation) {
      setState(() {
        ourcontent = const CircularProgressIndicator();
      });
    }
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2, color: Theme.of(context).colorScheme.primary),
            ),
            height: 150,
            width: double.infinity,
            child: ourcontent),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
                icon: Icon(Icons.location_on_outlined),
                onPressed: _getloaction,
                label: Text(' Current Location ')),
            ElevatedButton.icon(
                icon: Icon(Icons.map_sharp),
                onPressed: () {},
                label: Text(
                  'Choose on Map',
                ))
          ],
        )
      ],
    );
  }
}
