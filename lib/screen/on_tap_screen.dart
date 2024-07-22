import 'package:flutter/material.dart';
import 'package:map/data/locationdatas.dart';
import 'package:map/main.dart';

class OnTapScreen extends StatelessWidget {
  OnTapScreen(this.selectedlocation, {super.key});
  Locationdatas selectedlocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedlocation.title),
        ),
        body: Stack(
          children: [
            Image.file(
              selectedlocation.imgae,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 79,
                      backgroundImage: NetworkImage(
                          'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/master/pass/GoogleMapTA.jpg'),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal:80, vertical: 16),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black54],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Latitude : ${selectedlocation.place.latitude}  & \n Longitude : ${selectedlocation.place.longitude}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
