import 'package:get/get.dart';
// import 'package:streetpark/pages/Login.dart';
import 'package:streetpark/pages/Home.dart';
// import 'package:streetpark//homepage/homepage.dart';

var pages = [
  GetPage(
    name: '/homepage',
    page: () => Home(),
    transition: Transition.rightToLeft,
  ),

];
