import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:map/data/locationdatas.dart';
import 'package:http/http.dart' as http;

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key, required this.onSelectedLocation});
  final Function(LocationDetails location) onSelectedLocation;
  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  LocationDetails? _pickedlocation;
  bool _isgettinglocation = false;

  void _getloaction() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isgettinglocation = true;
    });
    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final long = locationData.longitude;
    if (lat == null || long == null) {
      return;
    }
    if (lat != null || long != null) {
      setState(() {
        _pickedlocation = LocationDetails(latitude: lat, longitude: long);
        _isgettinglocation = false;
      });
      widget.onSelectedLocation(_pickedlocation!);
    }
// the codes below are used to get the maplocation view from google with the help of API - PAID
    //   final url = Uri.parse(
    //       'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyA0dU6bvJ0LAEbJSS4aWajev5DDZmeiyK0');
    //   final res = await http.get(url);
    //   final responseData = json.decode(res.body);
    //   print(responseData);
    //   var humanreadableAddreass = responseData['results'][0]['formatted_address'];

    //   setState(() {
    //     _pickedlocation = LocationDetails(
    //         latitude: lat, longitude: long, addreass: humanreadableAddreass);
    //     _isgettinglocation = false;
    //   });

    //   widget.onSelectedLocation(_pickedlocation!);
    // }

    // String get google_map_image_link_getter {
    //   final lat = _pickedlocation!.latitude;
    //   final long = _pickedlocation!.longitude;

    //   if (_pickedlocation == null) {
    //     return '';
    //   }
    //   return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$long&key=AIzaSyA0dU6bvJ0LAEbJSS4aWajev5DDZmeiyK0';
  }

  @override
  Widget build(BuildContext context) {
    // if (_pickedlocation != null) {
    //   ourcontent = Image.network(
    //     google_map_image_link_getter,
    //     fit: BoxFit.cover,
    //     width: double.infinity,
    //     height: double.infinity,
    //   );
    // }
    Widget ourcontent = const Text('No Location Choosen yet');
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
                icon: const Icon(Icons.location_on_outlined),
                onPressed: _getloaction,
                label: const Text(' Current Location ')),
            ElevatedButton.icon(
                icon: const Icon(Icons.map_sharp),
                onPressed: () {},
                label: const Text(
                  'Choose on Map',
                ))
          ],
        )
      ],
    );
  }
}
