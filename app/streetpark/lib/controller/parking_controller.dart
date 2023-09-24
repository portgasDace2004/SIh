import 'dart:convert';
import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../config/colors.dart';
import 'model/car_model.dart';

class ParkingController extends GetxController {
  final fb = FirebaseDatabase.instance;
  var parkingHours = 10.0.obs;
  var amountPay = 100.0.obs;
  var selectedFloor = "1st Floor".obs;
  TextEditingController name = TextEditingController();
  var slot1Time = "".obs;
  var slot2Time = "".obs;
  var slot3Time = "".obs;
  var slot4Time = "".obs;
  var slot5Time = "".obs;
  var slot6Time = "".obs;
  var slot7Time = "".obs;
  var slot8Time = "".obs;
  var slot1KEY = "-NRdY57houxuL83j7cok";
  var slot2KEY = "-NRdYRojJXhw3_aixhnM";
  var slot3KEY = "-NRdYTO7yp_MbMxjhic3";
  var slot4KEY = "-NRdYWXOcd8oWymDLroj";
  var slot5KEY = "-NRh9RiMNakdmIi6fZUv";
  var slot6KEY = "-NRh9UdC92OokxV__NlW";
  var slot7KEY = "-NRhCKffU8n0q23MErf5";
  var slot8KEY = "-NRhCR1Szb2a59nUtcfs";
  var slot1 = CarModel().obs;
  var slot2 = CarModel().obs;
  var slot3 = CarModel().obs;
  var slot4 = CarModel().obs;
  var slot5 = CarModel().obs;
  var slot6 = CarModel().obs;
  var slot7 = CarModel().obs;
  var slot8 = CarModel().obs;

  @override
  void onInit() {
    super.onInit();
    startDataUpdates();
  }

  void amountCalculator() {
    amountPay.value = parkingHours.value * 2;
  }

  void updateData(String slotId) async {
    await fb.ref().child(slotId).update(
      {
        "name": name.text,
        "parkingHours": parkingHours.toString(),
        "paymentDone": true,
        "booked": true,
      },
    );
    print("Data Updated");
    Get.defaultDialog(
        barrierDismissible: false,
        title: "SLOT BOOKED",
        titleStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: blueColor,
        ),
        content: Column(
          children: [
            Lottie.asset(
              'assets/animation/done1.json',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Your Slot Booked",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.currency_rupee,
                  size: 40,
                  color: blueColor,
                ),
                Text(
                  amountPay.value.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: blueColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed("/homepage");
              },
              child: Text("Close"),
            )
          ],
        ));

    if (slotId == slot1KEY) {
      slot1Controller();
    } else if (slotId == slot2KEY) {
      slot2Controller();
    } else if (slotId == slot3KEY) {
      slot3Controller();
    } else if (slotId == slot4KEY) {
      slot4Controller();
    } else if (slotId == slot5KEY) {
      slot5Controller();
    } else if (slotId == slot6KEY) {
      slot6Controller();
    } else if (slotId == slot7KEY) {
      slot7Controller();
    } else {
      slot8Controller();
    }
  }

  void startDataUpdates() async {
    while (true) {
      getData();
      await Future.delayed(Duration(seconds: 1));
      print("Data loaded");
    }
  }

  void getData() async {
    final DatabaseReference res1 = fb.ref().child(slot1KEY);
    res1.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      slot1.value = CarModel.fromJson(
        json.decode(
          json.encode(dataSnapshot.value),
        ),
      );
    });
    final DatabaseReference res2 = fb.ref().child(slot2KEY);
    res2.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      slot2.value = CarModel.fromJson(
        json.decode(
          json.encode(dataSnapshot.value),
        ),
      );
    });
    final DatabaseReference res3 = fb.ref().child(slot3KEY);
    res3.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      slot3.value = CarModel.fromJson(
        json.decode(
          json.encode(dataSnapshot.value),
        ),
      );
    });
    final DatabaseReference res4 = fb.ref().child(slot4KEY);
    res4.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      slot4.value = CarModel.fromJson(
        json.decode(
          json.encode(dataSnapshot.value),
        ),
      );
    });
    final DatabaseReference res5 = fb.ref().child(slot5KEY);
    res5.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      slot5.value = CarModel.fromJson(
        json.decode(
          json.encode(dataSnapshot.value),
        ),
      );
    });
    final DatabaseReference res6 = fb.ref().child(slot6KEY);
    res6.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      slot6.value = CarModel.fromJson(
        json.decode(
          json.encode(dataSnapshot.value),
        ),
      );
    });
    final DatabaseReference res7 = fb.ref().child(slot7KEY);
    res7.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      slot7.value = CarModel.fromJson(
        json.decode(
          json.encode(dataSnapshot.value),
        ),
      );
    });
    final DatabaseReference res8 = fb.ref().child(slot8KEY);
    res8.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      slot8.value = CarModel.fromJson(
        json.decode(
          json.encode(dataSnapshot.value),
        ),
      );
    });
  }
  // void deleteData() {
  //   _databaseReference.remove();
  // }

  void addCar(CarModel car) {
    fb.ref().push().set(car.toJson());
  }

  void slot1Controller() async {
    double time = double.parse(slot1.value.parkingHours.toString());

    while (time != 0) {
      await Future.delayed(Duration(seconds: 1));
      time--;
      print(time);
      await fb.ref().child(slot1KEY).update(
        {
          "parkingHours": time.toString(),
        },
      );
    }

    await fb.ref().child(slot1KEY).update(
      {
        "paymentDone": false,
        "booked": false,
        "isParked": false,
      },
    );
    print("Slot 1 time ended : Slot 1 updated");
  }

  void slot2Controller() async {
    double time = double.parse(slot2.value.parkingHours.toString());

    while (time != 0) {
      await Future.delayed(Duration(seconds: 1));
      time--;
      print(time);
      await fb.ref().child(slot2KEY).update(
        {
          "parkingHours": time.toString(),
        },
      );
    }

    await fb.ref().child(slot2KEY).update(
      {
        "paymentDone": false,
        "booked": false,
        "isParked": false,
      },
    );
    print("Slot 1 time ended : Slot 1 updated");
  }

  void slot3Controller() async {
    double time = double.parse(slot3.value.parkingHours.toString());

    while (time != 0) {
      await Future.delayed(Duration(seconds: 1));
      time--;
      print(time);
      await fb.ref().child(slot3KEY).update(
        {
          "parkingHours": time.toString(),
        },
      );
    }

    await fb.ref().child(slot3KEY).update(
      {
        "paymentDone": false,
        "booked": false,
        "isParked": false,
      },
    );
    print("Slot 3 time ended : Slot 1 updated");
  }

  void slot4Controller() async {
    double time = double.parse(slot4.value.parkingHours.toString());

    while (time != 0) {
      await Future.delayed(Duration(seconds: 1));
      time--;
      print(time);
      await fb.ref().child(slot4KEY).update(
        {
          "parkingHours": time.toString(),
        },
      );
    }

    await fb.ref().child(slot4KEY).update(
      {
        "paymentDone": false,
        "booked": false,
        "isParked": false,
      },
    );
    print("Slot 4 time ended : Slot 1 updated");
  }

  void slot5Controller() async {
    double time = double.parse(slot5.value.parkingHours.toString());

    while (time != 0) {
      await Future.delayed(Duration(seconds: 1));
      time--;
      print(time);
      await fb.ref().child(slot5KEY).update(
        {
          "parkingHours": time.toString(),
        },
      );
    }

    await fb.ref().child(slot5KEY).update(
      {
        "paymentDone": false,
        "booked": false,
        "isParked": false,
      },
    );
    print("Slot 5 time ended : Slot 5 updated");
  }

  void slot6Controller() async {
    double time = double.parse(slot6.value.parkingHours.toString());

    while (time != 0) {
      await Future.delayed(Duration(seconds: 1));
      time--;
      print(time);
      await fb.ref().child(slot6KEY).update(
        {
          "parkingHours": time.toString(),
        },
      );
    }

    await fb.ref().child(slot6KEY).update(
      {
        "paymentDone": false,
        "booked": false,
        "isParked": false,
      },
    );
    print("Slot 6 time ended : Slot 6 updated");
  }

  void slot7Controller() async {
    double time = double.parse(slot7.value.parkingHours.toString());

    while (time != 0) {
      await Future.delayed(Duration(seconds: 1));
      time--;
      print(time);
      await fb.ref().child(slot7KEY).update(
        {
          "parkingHours": time.toString(),
        },
      );
    }

    await fb.ref().child(slot7KEY).update(
      {
        "paymentDone": false,
        "booked": false,
        "isParked": false,
      },
    );
    print("Slot 7 time ended : Slot 7 updated");
  }

  void slot8Controller() async {
    double time = double.parse(slot8.value.parkingHours.toString());

    while (time != 0) {
      await Future.delayed(Duration(seconds: 1));
      time--;
      print(time);
      await fb.ref().child(slot8KEY).update(
        {
          "parkingHours": time.toString(),
        },
      );
    }

    await fb.ref().child(slot8KEY).update(
      {
        "paymentDone": false,
        "booked": false,
        "isParked": false,
      },
    );
    print("Slot 8 time ended : Slot 8 updated");
  }
}
