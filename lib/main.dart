import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map/add_screen.dart';
import 'package:map/data/locationdatas.dart';
import 'package:map/screen/on_tap_screen.dart';

var theme = ThemeData().copyWith(
  colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 51, 24, 172),
      background: Color.fromARGB(255, 12, 48, 65)),
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
  ),
);

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'great places',
        theme: theme,
        // darkTheme: ThemeData.dark(),
        home: const Home()),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _additem() async {
    final valueget = await Navigator.of(context).push<dynamic>(
        MaterialPageRoute(builder: (builder) => const Add_Screen()));
    setState(() {
      locationdatas.add(valueget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _additem,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
          const SizedBox(width: 8),
        ],
        title: Text(
          'Great Places ',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: locationdatas.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) =>
                      OnTapScreen(locationdatas[index].title)));
            },
            child: ListTile(
              enabled: true,
              title: Text(
                locationdatas[index].title,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          );
        },
      ),
    );
  }
}
