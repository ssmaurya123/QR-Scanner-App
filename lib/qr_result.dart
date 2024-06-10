import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner_app/main.dart';

// A stateless widget that displays the QR code result.
class QRResult extends StatelessWidget {
    // Variables to hold the scanned code and a function to close the screen.
  final String code;
  final Function() closeScreen;

  // Constructor to initialize the variables

  const QRResult({
    super.key,
    required this.code,
    required this.closeScreen
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the basic structure for the screen
      appBar: AppBar(
        //Setting appbar here 
        backgroundColor: const Color.fromARGB(255, 151, 72, 98),
        //Adding back button to go again on QRScanner Screen
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return QRScanner();// Navigate to QRScanner screen on button press
                  },
                ));
          },
          icon: Icon(Icons.arrow_back),// Back icon
          color: Colors.white,// Icon color--->White
        ),
        centerTitle: true,
        title: Text(
          "Your Result",// Title of the app bar
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(60), // Padding around the body
        child: Column(
          // Column to arrange widgets vertically
          children: [
            SizedBox(
              height: 120, // Spacing at the top
            ),
            QrImageView(
                data: "",// Data for QR code, currently empty
              size: 300,
              version: QrVersions.auto,
            ),
            Text(
              "Scanned QR",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              code,// Display the scanned code
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              // Button for copying the code
              width: MediaQuery.of(context).size.width - 150,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 151, 72, 98)
                ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                  },
                  child: Text(
                    "Copy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}