import 'package:flutter/material.dart';//Importing the Flutter Material package.
import 'package:mobile_scanner/mobile_scanner.dart';// Importing the mobile_scanner package for QR code scanning.
import 'package:qr_scanner_app/qr_result.dart'; // Importing the QRResult screen from the qr_scanner_app package.
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';// Importing the QRScannerOverlay widget.

void main() {
  runApp(const MyApp());// Running the app by calling the runApp function with MyApp widget.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      debugShowCheckedModeBanner: false,
      home: QRScanner(),// Setting the home widget to QRScanner.
    );
  }
}

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isFlashOn = false;
  bool isFrontCamera = false;
  bool isScanCompleted = false;// Boolean to track if the scan is completed.
  MobileScannerController cameraController = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;// Resetting scan completion status.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,// Setting the background color to white.
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          //Used column widget to arrange children widget vertically in a top down fashion.
          children: [
            Expanded(
              //using image here to display MOE image as its not sure whether we have to create or use that as image 
              //I can design that,if needed .......please take that into consideration.
              child: Image.asset(
                'assets/intern.jpg',// Displaying an image from the assets.
                //changes made in pubspec.yaml also for able to include image 
                width: 240,
              ),
            ),
            SizedBox(
              height: 20,// Adding vertical spacing.
            ),
            Expanded(
              // flex property determines how much space the child should occupy relative to other Expanded widgets in the same Column.
              // Here, this Expanded widget will occupy twice the space of other widgets with flex: 1 in the same parent Column.
                flex: 2,
                child: Stack(
                  // Using Stack widget to overlay widgets on top of each other.
                  children: [
                    MobileScanner(
                      controller: cameraController,//Controlling scanner.
                      allowDuplicates: true,//To allow duplicate scans.
                      onDetect: (barcode, args) {
                        //Function called when barcode is detected by scanner
                        if (!isScanCompleted) {
                          isScanCompleted = true; //If isScanCompleted false,then set it to true.
                          String code = barcode.rawValue ?? "---";// Getting the barcode value or setting to '---' if null.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return QRResult(
                                code: code,// Passing the scanned code to QRResult screen.
                                closeScreen: closeScreen,// Passing the closeScreen function.
                              );
                            }),
                          );//Navigating to a new Screen named QRResult.
                        }
                      },
                    ),
                    QRScannerOverlay(
                      overlayColor: Colors.white,
                      borderColor: Colors.black,
                      borderRadius: 30,
                      borderStrokeWidth: 5,
                      scanAreaWidth: 292,
                      scanAreaHeight: 292,
                    )
                    //Another widget (QRScannerOverlay) used to provide a visual overlay for the QR code scanner.
                  ],
                )),
            Expanded(
              //Expanded used for taking up available space.
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,//This property aligns the children of the Column in the center along the main axis (vertical axis for Column).
              children: [
                Text(
                  "Scannen Sie den QR-code",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: Text(
                    "Scannen Sie den QR-code auf der Unterseite des Gateways,um die Installation fortzusetzen",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,//Aligns the text to the center.
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
