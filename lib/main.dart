import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'views/home_page.dart';

void main() {
  sqfliteFfiInit();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SQFlite plays',
      home: const Home(),
      getPages: [
        GetPage(name: '/', page: () => const Home()),
      ],
    );
  }
}
