import 'package:flutter/material.dart';
import 'package:devices/helpers/devices_helpers.dart';
import 'package:devices/helpers/controleslistdevices.dart';

class DevicesPage extends StatefulWidget {
  // Aqui irie chamar minhas lista fixas para o Formfield

  //Função para editar contatos quando estivermos dentro das informações
  final Devices? devices;
  DevicesPage({this.devices});

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final _tipoController = TextEditingController();
  final _modeloController = TextEditingController();
  final _memoriaController = TextEditingController();
  final _corController = TextEditingController();
  final _custoController = TextEditingController();
  final _numerodeserieController = TextEditingController();
  final _bateriaController = TextEditingController();

  final _tiposs = tipos;
  String? _tipossinput;

  bool _useredit = false;
  late Devices _editDevices;

  DevicesHelper helper = DevicesHelper();
  @override
  void initState() {
    super.initState();
    if (widget.devices == null) {
      _editDevices = Devices();
    } else {
      _editDevices = Devices.fromMap(
        widget.devices!.toMap() as Map<String, dynamic>,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(_editDevices.tipo ?? 'Novo Device'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          helper.saveDevices(_editDevices);
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              items: _tiposs.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: _tipossinput,
              onChanged: (_tipossinput) {
                _editDevices.tipo = _tipossinput;
              },
            ),
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
              //com on change mudamos o titulo e ainda criamos a regra se houver alguma mundaça ele apresenta um aviso caso seja fechado sem salvar.
              onChanged: (text) {
                _useredit = true;
                _editDevices.modelo = text;
              },
            ),
            TextField(
              controller: _memoriaController,
              decoration: InputDecoration(labelText: 'Memoria'),
              //com on change mudamos o titulo e ainda criamos a regra se houver alguma mundaça ele apresenta um aviso caso seja fechado sem salvar.
              onChanged: (text) {
                _useredit = true;
                _editDevices.memoria = text;
              },
            ),
            TextField(
              controller: _corController,
              decoration: InputDecoration(labelText: 'Cor'),
              //com on change mudamos o titulo e ainda criamos a regra se houver alguma mundaça ele apresenta um aviso caso seja fechado sem salvar.
              onChanged: (text) {
                _useredit = true;
                _editDevices.cor = text;
              },
            ),
            TextField(
              controller: _custoController,
              decoration: InputDecoration(labelText: 'Custo'),
              onChanged: (text) {
                _useredit = true;
                _editDevices.custo = text;
              },
            ),
            TextField(
              controller: _numerodeserieController,
              decoration: InputDecoration(labelText: 'NS'),
              onChanged: (text) {
                _useredit = true;
                _editDevices.numerodeserie = text;
              },
            ),
            TextField(
              controller: _bateriaController,
              decoration: InputDecoration(labelText: 'Bateria'),
              onChanged: (text) {
                _useredit = true;
                _editDevices.bateria = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
