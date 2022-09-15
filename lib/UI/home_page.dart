import 'package:devices/UI/devices_page.dart';
import 'package:devices/helpers/devices_helpers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DevicesHelper helper = DevicesHelper();

  //Criando minha lista de devices
  List<dynamic> devices = [];

  @override
  void initState() {
    super.initState();
    helper.getAllDevices().then((list) {
      setState(() {
        devices = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APARELHOS'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDevicesPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: devices.length,
          itemBuilder: ((context, index) {
            return _devicesCard(context, index);
          })),
    );
  }

  Widget _devicesCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(children: [
            Row(children: <Widget>[
              Text(
                devices[index].tipo ?? '',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(2.0)),
              Text(
                devices[index].modelo ?? '',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(2.0)),
              Text(
                devices[index].memoria ?? '',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(2.0)),
              Text(
                devices[index].cor ?? '',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
            ]),
            Padding(padding: EdgeInsets.all(5.0)),
            Row(children: <Widget>[
              Text(
                'CUSTO:',
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Padding(padding: EdgeInsets.all(1.0)),
              Text(
                devices[index].custo ?? '',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Text(
                'NS:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.all(1.0)),
              Text(
                devices[index].numerodeserie ?? '',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(2.0)),
              Text(
                'SAUDE:',
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Padding(padding: EdgeInsets.all(1.0)),
              Text(
                devices[index].bateria ?? '',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            ]),
          ]),
        ),
      ),
      onTap: () {
        _showDevicesPage(devices: devices[index]);
      },
    );
  }

  void _showDevicesPage({Devices? devices}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DevicesPage(
                  devices: devices,
                )));
  }
}
