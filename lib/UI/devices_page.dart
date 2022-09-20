import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:devices/helpers/devices_helpers.dart';
import 'package:devices/helpers/controleslistdevices.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:sqflite/sqflite.dart';

class DevicesPage extends StatefulWidget {
  // Aqui irie chamar minhas lista fixas para o Formfield

  //Função para editar contatos quando estivermos dentro das informações
  final Devices? devices;
  DevicesPage({this.devices});

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  // Criando a lista de tipo
  List<dynamic> tipos = [];
  //criando a lista de modelos com dados
  List<dynamic> modelosState = [];
  //criando a lista de modelos a partia de um estado
  List<dynamic> mState = [];

  // Criando a lista de memorias com dados
  List<dynamic> memoriaState = [];
  //criando a lista de modelos a partia de um estado
  List<dynamic> meState = [];

  // Criando a lista de cor com dados
  List<dynamic> corState = [];
  //criando a lista de cor a partia de um estado
  List<dynamic> cState = [];

  // // Criando String para mandar para o banco
  // List<dynamic> tipooinput = [];
  // String? tipoinput;
  // late Map teste;

  String? tiposId;
  String? mStateID;
  String? meStateID;
  String? cStateID;

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

    this.tipos.add({'id': 1, 'name': 'iPhone'});
    this.tipos.add({'id': 2, 'name': 'Macbook'});
    this.tipos.add({'id': 3, 'name': 'iPad'});
    this.tipos.add({'id': 4, 'name': 'Apple Watch'});
    this.tipos.add({'id': 5, 'name': 'Air Pods'});

    this.modelosState = [
      {'ID': 1, 'Name': '6', 'ParentId': 1},
      {'ID': 2, 'Name': '6 Plus', 'ParentId': 1},
      {'ID': 3, 'Name': '6s', 'ParentId': 1},
      {'ID': 4, 'Name': '6s Plus', 'ParentId': 1},
      {'ID': 5, 'Name': 'SE 1ª', 'ParentId': 1},
      {'ID': 6, 'Name': '7', 'ParentId': 1},
      {'ID': 7, 'Name': '7 Plus', 'ParentId': 1},
      {'ID': 8, 'Name': '8', 'ParentId': 1},
      {'ID': 9, 'Name': '8 Plus', 'ParentId': 1},
      {'ID': 10, 'Name': 'X', 'ParentId': 1},
      {'ID': 11, 'Name': 'XR', 'ParentId': 1},
      {'ID': 12, 'Name': 'XS', 'ParentId': 1},
      {'ID': 13, 'Name': 'XS MAX', 'ParentId': 1},
      {'ID': 14, 'Name': 'SE 2ª', 'ParentId': 1},
      {'ID': 15, 'Name': '11', 'ParentId': 1},
      {'ID': 16, 'Name': '11 Pro', 'ParentId': 1},
      {'ID': 17, 'Name': '11 Pro Max', 'ParentId': 1},
      {'ID': 18, 'Name': '12', 'ParentId': 1},
      {'ID': 19, 'Name': '12 Mini', 'ParentId': 1},
      {'ID': 20, 'Name': '12 Pro', 'ParentId': 1},
      {'ID': 21, 'Name': '12 Pro Max', 'ParentId': 1},
      {'ID': 22, 'Name': '13', 'ParentId': 1},
      {'ID': 23, 'Name': '13 Mini', 'ParentId': 1},
      {'ID': 24, 'Name': '13 Pro', 'ParentId': 1},
      {'ID': 25, 'Name': '13 Pro Max', 'ParentId': 1},
      {'ID': 26, 'Name': 'SE 3ª', 'ParentId': 1},
      {'ID': 27, 'Name': '14', 'ParentId': 1},
      {'ID': 28, 'Name': '14 Plus', 'ParentId': 1},
      {'ID': 29, 'Name': '14 Pro', 'ParentId': 1},
      {'ID': 30, 'Name': '14 Pro Max', 'ParentId': 1},
      {'ID': 1, 'Name': '14 Pro Max', 'ParentId': 2},
      {'ID': 1, 'Name': '14 Pro Max', 'ParentId': 3},
      {'ID': 1, 'Name': '14 Pro Max', 'ParentId': 4},
      {'ID': 1, 'Name': '14 Pro Max', 'ParentId': 5},
    ];

    this.memoriaState = [
      {'IDme': 1, 'Name': '16 GB', 'ParentID': 1},
      {'IDme': 2, 'Name': '32 GB', 'ParentID': 1},
      {'IDme': 3, 'Name': '64 GB', 'ParentID': 1},
      {'IDme': 4, 'Name': '128 GB', 'ParentID': 1},
    ];

    this.corState = [
      {'IDc': 1, 'Name': 'Cinza-Espacial', 'ParentID': 1},
      {'IDc': 1, 'Name': 'Prateado', 'ParentID': 1},
      {'IDc': 1, 'Name': 'Dourado', 'ParentID': 1},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  setState(() {
                    this.mState = this
                        .modelosState
                        .where(
                          (stateItem) =>
                              stateItem['ParentId'].toString() ==
                              onChangedVal.toString(),
                        )
                        .toList();
                    this.mStateID = null;
                  });
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
                // optionValue: 'id',
                // optionLabel: 'label',
              ),
              FormHelper.dropDownWidgetWithLabel(
                context,
                'Modelos',
                'Selecione',
                this.mStateID,
                this.mState,
                (onChangedVal) {
                  this.mStateID = onChangedVal;
                  print('Selecione: $onChangedVal');

                  setState(() {
                    this.meState = this
                        .memoriaState
                        .where(
                          (stateItem) =>
                              stateItem['ParentID'].toString() ==
                              onChangedVal.toString(),
                        )
                        .toList();
                    this.meStateID = null;
                  });
                  setState(() {
                    this.cState = this
                        .corState
                        .where(
                          (stateItem) =>
                              stateItem['ParentID'].toString() ==
                              onChangedVal.toString(),
                        )
                        .toList();
                    this.cStateID = null;
                  });
                },
                (onValidate) {
                  return null;
                },
                borderColor: Theme.of(context).primaryColor,
                borderFocusColor: Theme.of(context).primaryColor,
                paddingLeft: 1,
                paddingRight: 1,
                borderRadius: 10,
                optionValue: 'ID',
                optionLabel: 'Name',
              ),
              FormHelper.dropDownWidgetWithLabel(
                context,
                'Memorias',
                'Selecione',
                this.meStateID,
                this.meState,
                (onChangedVal) {
                  this.meStateID = onChangedVal;
                  print('memorias: $onChangedVal');
                },
                (onValidate) {
                  return null;
                },
                borderColor: Theme.of(context).primaryColor,
                borderFocusColor: Theme.of(context).primaryColor,
                paddingLeft: 1,
                paddingRight: 1,
                borderRadius: 10,
                optionValue: 'IDme',
                optionLabel: 'Name',
              ),
              FormHelper.dropDownWidgetWithLabel(
                context,
                'Cores',
                'Selecione',
                this.cStateID,
                this.cState,
                (onChangedVal) {
                  this.cStateID = onChangedVal;
                  print('cores: $onChangedVal');
                },
                (onValidate) {
                  return null;
                },
                borderColor: Theme.of(context).primaryColor,
                borderFocusColor: Theme.of(context).primaryColor,
                paddingLeft: 1,
                paddingRight: 1,
                borderRadius: 10,
                optionValue: 'IDc',
                optionLabel: 'Name',
              ),

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
      ),
    );
  }
}
