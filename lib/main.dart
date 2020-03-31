import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController altController = TextEditingController();


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = 'Informe seus dados';

  void _resetFields() {
    pesoController.text = '';
    altController.text = '';
    setState(() {
      _info = 'Informe seus dados';
      _formKey =GlobalKey<FormState>();
    });
  }

  void _calculoIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double alt = double.parse(altController.text) / 100;

      double imc = (peso / (alt * alt));

      if (imc < 18.5) {
        _info = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.6 && imc <= 24.9) {
        _info = 'Peso ideal (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 25.0 && imc <= 29.9) {
        _info = 'Levemente acima do peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 30.0 && imc <= 34.9) {
        _info = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 35.0 && imc <= 39.9) {
        _info = 'Obesidade Grau II (severa) (${imc.toStringAsPrecision(4)})';
      } else {
        _info = 'Obesidade Grau III (morbida) (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC - Home Page'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child:Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 120.0,
                  color: Colors.deepPurple,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Peso em (kg)',
                      labelStyle: TextStyle(color: Colors.deepPurple)),
                  controller: pesoController,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Insira seu peso';
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Altura em (cm)',
                      labelStyle: TextStyle(color: Colors.deepPurple)),
                  controller: altController,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Insira seu peso';
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed:(){
                        if(_formKey.currentState.validate()){
                          _calculoIMC();
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Text(
                  '$_info',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                )
              ],
            ),
          )
        )
    );
  }
}
