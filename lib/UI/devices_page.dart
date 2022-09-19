import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:devices/helpers/devices_helpers.dart';
import 'package:devices/helpers/controleslistdevices.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class DevicesPage extends StatefulWidget {
  // Aqui irie chamar minhas lista fixas para o Formfield

  //Função para editar contatos quando estivermos dentro das informações
  final Devices? devices;
  DevicesPage({this.devices});

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  List<dynamic> tipos = [];
  List<dynamic> modelosState = [];
  List<dynamic> mState = [];

  // Criando String para mandar para o banco

  String? tipoinput;

  String? tiposId;
  String? mStateID;

  // Modelos? modelos;
  // //Aqui estou puxando a lista e instanciando e abaixo criando a variavel que será passada para o banco
  // final _tiposs = tipos;
  // String? _tipossinput;
  // final _modeloss = modelosiphone;
  // String? _modelossinput;

  final _tipoController = TextEditingController();
  final _modeloController = TextEditingController();
  final _memoriaController = TextEditingController();
  final _corController = TextEditingController();
  final _custoController = TextEditingController();
  final _numerodeserieController = TextEditingController();
  final _bateriaController = TextEditingController();

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

    this.tipos.add({'id': 1, 'label': 'iPhone'});
    this.tipos.add({'id': 2, 'label': 'Macbook'});
    this.tipos.add({'id': 3, 'label': 'iPad'});
    this.tipos.add({'id': 4, 'label': 'Apple Watch'});
    this.tipos.add({'id': 5, 'label': 'Air Pods'});

    this.modelosState = [
      {'id': 1, 'Name': '6', 'ParentId': 1},
      {'id': 2, 'Name': '6 Plus', 'ParentId': 1},
      {'id': 3, 'Name': '6s', 'ParentId': 1},
      {'id': 4, 'Name': '6s Plus', 'ParentId': 1},
      {'id': 5, 'Name': 'SE 1ª', 'ParentId': 1},
      {'id': 6, 'Name': '7', 'ParentId': 1},
      {'id': 7, 'Name': '7 Plus', 'ParentId': 1},
      {'id': 8, 'Name': '8', 'ParentId': 1},
      {'id': 9, 'Name': '8 Plus', 'ParentId': 1},
      {'id': 10, 'Name': 'X', 'ParentId': 1},
      {'id': 11, 'Name': 'XR', 'ParentId': 1},
      {'id': 12, 'Name': 'XS', 'ParentId': 1},
      {'id': 13, 'Name': 'XS MAX', 'ParentId': 1},
      {'id': 14, 'Name': 'SE 2ª', 'ParentId': 1},
      {'id': 15, 'Name': '11', 'ParentId': 1},
      {'id': 16, 'Name': '11 Pro', 'ParentId': 1},
      {'id': 17, 'Name': '11 Pro Max', 'ParentId': 1},
      {'id': 18, 'Name': '12', 'ParentId': 1},
      {'id': 19, 'Name': '12 Mini', 'ParentId': 1},
      {'id': 20, 'Name': '12 Pro', 'ParentId': 1},
      {'id': 21, 'Name': '12 Pro Max', 'ParentId': 1},
      {'id': 22, 'Name': '13', 'ParentId': 1},
      {'id': 23, 'Name': '13 Mini', 'ParentId': 1},
      {'id': 24, 'Name': '13 Pro', 'ParentId': 1},
      {'id': 25, 'Name': '13 Pro Max', 'ParentId': 1},
      {'id': 26, 'Name': 'SE 3ª', 'ParentId': 1},
      {'id': 27, 'Name': '14', 'ParentId': 1},
      {'id': 28, 'Name': '14 Plus', 'ParentId': 1},
      {'id': 29, 'Name': '14 Pro', 'ParentId': 1},
      {'id': 30, 'Name': '14 Pro Max', 'ParentId': 1},
    ];
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
            FormHelper.dropDownWidgetWithLabel(
              context,
              'Tipos',
              'Selecione',
              this.tiposId,
              this.tipos,
              (onChangedVal) {
                this.tiposId = onChangedVal;
                print('Tipos: $onChangedVal');

                this.mState = this
                    .modelosState
                    .where(
                      (stateItem) =>
                          stateItem['ParentId'].toString() ==
                          onChangedVal.toString(),
                    )
                    .toList();
                this.mStateID = null;
              },
              (onValidateVal) {
                if (onValidateVal == null) {
                  return 'Por Favor selecione um tipo';
                }
                return null;
              },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              paddingLeft: 1,
              paddingRight: 1,
              borderRadius: 10,
              optionValue: 'id',
              optionLabel: 'label',
            ),
            // FormHelper.dropDownWidgetWithLabel(
            //   context,
            //   'Modelos',
            //   'Selecione',
            //   this.mStateID,
            //   this.mState,
            //   (onChangedVal) {
            //     this.mStateID = onChangedVal;
            //     print('Selecione: $onChangedVal');
            //   },
            //   (onValidate) {
            //     return null;
            //   },
            //   borderColor: Theme.of(context).primaryColor,
            //   borderFocusColor: Theme.of(context).primaryColor,
            //   paddingLeft: 1,
            //   paddingRight: 1,
            //   borderRadius: 10,
            //   optionValue: 'id',
            //   optionLabel: 'Name',
            // ),

            //  DropdownButtonFormField<String>(
            //    items: _modeloss?.map((String value) {
            //      return DropdownMenuItem<String>(
            //        value: value,
            //        child: Text(value),
            //      );
            //    }).toList(),
            //    value: _modelossinput,
            //    onChanged: (_modelossinput) {
            //      _editDevices.tipo = _modelossinput;
            //    },
            //  ),
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: 'Memoria'),
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
