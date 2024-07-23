import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map/add_screen.dart';
import 'package:map/providers/list_provider.dart';
import 'package:map/screen/on_tap_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var theme = ThemeData().copyWith(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 68, 33, 223),
    surface: const Color.fromARGB(255, 34, 31, 54),
    //background: Color.fromARGB(255, 209, 98, 25),
  ),
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
  ),
);

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'great places',
        theme: theme,
        // darkTheme: ThemeData.dark(),
        home: const Home()),
  ));
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late Future<void> _loadfuture;

  @override
  void initState() {

    super.initState();
    _loadfuture = ref.read(addplacenotifier.notifier).loaddata();
  }

  @override
  Widget build(BuildContext context) {
    final providerlist = ref.watch(addplacenotifier);

    Widget content = ListView.builder(
      itemCount: providerlist.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => OnTapScreen(providerlist[index])));
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(providerlist[index].imgae),
            ),
            enabled: true,
            title: Text(
              providerlist[index].title,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            subtitle: Text(
              'Latitude : ${providerlist[index].place.latitude}, Longitude :${providerlist[index].place.longitude}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        );
      },
    );
    if (providerlist.isEmpty) {
      content = const Center(
        child: Text('No Places Added Yet'),
      );
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => const Add_Screen()));
                },
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
        body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FutureBuilder(
              future: _loadfuture,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : content;
              },
            )));
  }
}
  // void _additem() async {
  //   final valueget = await Navigator.of(context).push<dynamic>(
  //       MaterialPageRoute(builder: (builder) => const Add_Screen()));
  //   setState(() {
  //     locationdatas.add(valueget);
  //   });
  // }