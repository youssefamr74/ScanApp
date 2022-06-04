import 'package:flutter/material.dart';
import 'package:untitled/screens/bluetooth.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/yLOOp.jpg"),
                fit: BoxFit.cover),
          ),
        child : Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 30,right: 30),
              child: IconButton(
                icon: const Icon(Icons.bluetooth_outlined , color: Colors.white,size: 50,),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BluetoothScreen()));
                },
              ),
            ),
            Text('Bluetooth',style: TextStyle(color: Colors.white,fontSize: 30)),
          ],
        ), // Foreground widget here
      ),
    ) ;
  }
}
