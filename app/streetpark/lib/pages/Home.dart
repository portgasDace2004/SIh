  import 'package:flutter/material.dart';
  import 'Login.dart';
  import 'Register.dart';
  import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'package:streetpark/pages/Book.dart';
  import 'package:streetpark/config/colors.dart';
  class Home extends StatelessWidget {
    BuildContext? _context;

    Home({Key? key}) : super(key: key);

    // Preload the custom marker icons
    final Future<BitmapDescriptor?> greenIcon = _loadCustomIcon('assets/images/green.png');
    final Future<BitmapDescriptor?> redIcon = _loadCustomIcon('assets/images/red.png');

    static Future<BitmapDescriptor?> _loadCustomIcon(String assetName) async {

      // Ensure that Flutter has fully initialized
      WidgetsFlutterBinding.ensureInitialized();

      return BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          devicePixelRatio: 2.0,
        ),
        assetName,
      );
    }
    void _showBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
          color: darkBgColor,
          child: Column(
            children: [
              Text(
                'Closest Parking Spaces\n',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              // Button 1
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Book()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'AS',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '23',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'TS',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '34',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Parking Space 1',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10), // Add some spacing
              // Button 2 (Add more buttons as needed)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Book()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'AS',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '45',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'TS',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '56',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Parking Space 2',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10), // Add some spacing
              // Add more buttons as needed
            ],
          ),
          );
        },
      );
    }


    @override
    Widget build(BuildContext context) {
      _context = context;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: blueColor,
          title: Text(
            "XPARK",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              icon: Icon(Icons.account_circle,
              size: 50,
              color: Colors.white,),),

          ],),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search for parking spaces',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                ),
                // Add any search functionality here
              ),
            ),

            Expanded(
              flex: 5,
        child: FutureBuilder<List<Marker>>(
          future: _loadMarkers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // Display an error message if there was an error loading the image
                return Center(
                  child: Text("Error loading image: ${snapshot.error}"),
                );
              } else if (snapshot.data != null) {
                // Use the custom marker icons here
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(28.4495015, 77.5809025),
                    zoom: 20.0,
                  ),
                  myLocationEnabled: true,
                  // mapType: MapType.satellite,
                  markers: snapshot.data!.toSet(),
                );
              } else {
                // Show a loading indicator while the images are being loaded
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              // While the future is still loading
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
            ),
            Expanded(
              flex: 0,

              child: Column(
              children: [
                Icon(Icons.keyboard_arrow_up),

                GestureDetector(
              onTap: () {
              _showBottomSheet(context);
              },

              child: Text(
              'Closest Parking Spaces',
              style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              ),
              ),
            ),
        ],
        ),
      ),
      ],
      ),
        );
    }

    Future<List<Marker>> _loadMarkers() async {
      final greenIconBitmap = await greenIcon;
      final redIconBitmap = await redIcon;

      return [
        Marker(
          markerId: MarkerId('customMarkerGreen'),
          position: LatLng(28.4494608, 77.5809233),
          icon: greenIconBitmap!, // Use the green icon
          infoWindow: InfoWindow(
          // Set the title and snippet for the info window
          title: 'Parking Space 1',
          // snippet: 'Available Space=23',
          ),

          ),

        Marker(
          markerId: MarkerId('customMarkerRed'),
          position: LatLng(28.4495740, 77.5805642),
          icon: redIconBitmap!, // Use the red icon
          infoWindow: InfoWindow(
            // Set the title and snippet for the info window
            title: 'Parking Space 2',
            // snippet: 'Available Space=2',
            onTap: () {
              print('Marker Pressed');
              Navigator.push(_context!, MaterialPageRoute(builder: (context) => Book()));
            },
          ),

        ),
        Marker(
          markerId: MarkerId('customMarkerGreen'),
          position: LatLng(28.4497223, 77.5807443),
          icon: greenIconBitmap!, // Use the green icon
          infoWindow: InfoWindow(
            // Set the title and snippet for the info window
            title: 'Parking Space 3',
            // snippet: 'Available Space=13',
            onTap: () {
              print('Marker Pressed');
              Navigator.push(_context!, MaterialPageRoute(builder: (context) => Book()));
            },
          ),

        ),
        // Add more markers as needed
      ];
    }
  }



