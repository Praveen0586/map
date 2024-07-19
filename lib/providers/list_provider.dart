import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map/data/locationdatas.dart';

class AddStateNotifier extends StateNotifier<List<Locationdatas>> {
  AddStateNotifier() : super(const []);

  void additem(String title) {
    var newitem = Locationdatas(title);
    state = [newitem, ...state];
  }
}

var addplacenotifier =
    StateNotifierProvider<AddStateNotifier, List<Locationdatas>>(
        (ref) => AddStateNotifier());
