import 'package:flutter/material.dart';
import 'components/firebase_options.dart';
import 'pages/Home.dart';
import 'package:lottie/lottie.dart';
import 'package:streetpark/controller/splace_controller.dart';
import 'package:get/get.dart';
import 'config/routes.dart';
import 'package:streetpark/pages/splace_page/splace_screen.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase, FirebaseOptions;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    SplaceController splaceController = Get.put(SplaceController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Parking',
      getPages: pages,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true),
      home: const Splace_Screen(),
    );
  }
}



