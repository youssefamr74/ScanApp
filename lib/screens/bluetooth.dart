import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';

class BluetoothScreen extends StatefulWidget{
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> deviceslist = List<BluetoothDevice>.empty(growable: true);
  bool scanbool = true;
  String scanstr = "Scan";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }

  void scan() async{
    scanstr = "Stop Scanning...";
    setState(() {

    });
     await flutterBlue.scanResults.listen((List<ScanResult> results) {
        for (ScanResult result in results) {
          addDeviceTolist(result.device);
        }
      });
      await flutterBlue.startScan();
    }
  stopScan(){
    flutterBlue.stopScan();
    scanstr = "Scan";
    setState(() {

    });
  }
  addDeviceTolist(final BluetoothDevice device) {
    if (!deviceslist.contains(device)) {
      if(mounted){
        setState(() {
          deviceslist.add(device);
        });
      }
      }

  }
  @override
  ListView _buildListViewOfDevices() {
    List<Container> containers = List<Container>.empty(growable: true);
    for (BluetoothDevice device in deviceslist) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name,style: TextStyle(fontSize: 20,color: Colors.white),),
                    Text(device.id.toString(),style: TextStyle(fontSize: 20,color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Bluetooth"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.expand(),
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/yLOOp.jpg"),
    fit: BoxFit.cover),
    ),
    child : !deviceslist.isEmpty? _buildListViewOfDevices(): !scanbool?CircularProgressIndicator(
      color: Colors.white,
      semanticsValue: "Scanning",
    ):null
      ),
      floatingActionButton:TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.white,
          primary: Colors.blue,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {if(scanbool){
        scanbool = false;

    scan();
    }
         else{
           stopScan();
           scanbool = true;
        }
        },
        child:  Text("${scanstr}"),
      ) ,
    );
  }
}