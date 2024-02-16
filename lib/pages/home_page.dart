import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();

  GlobalKey<FormState> _chaveFormulario = GlobalKey<FormState>();

  String _informacoes = "Insira seus dados acima";

  void _resetarCampos() {
    controllerPeso.text = "";
    controllerAltura.text = "";
    setState(() {
      _informacoes = "Insira seus dados acima";
      _chaveFormulario = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    double peso = double.parse(controllerPeso.text);
    double altura = double.parse(controllerAltura.text) / 100;
    double imc = peso / (altura * altura);
    setState(() {
      if (imc < 18.6) {
        _informacoes = "Abaixo do Peso, IMC:${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _informacoes = "Peso Ideal, IMC:${imc.toStringAsPrecision(3)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _informacoes =
            "Levemente Acima do Peso, IMC:${imc.toStringAsPrecision(3)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        _informacoes = "Obesidade Grau I, IMC:${imc.toStringAsPrecision(3)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _informacoes = "Obesidade Grau II, IMC:${imc.toStringAsPrecision(3)}";
      } else if (imc >= 40) {
        _informacoes = "Obesidade Grau III, IMC:${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Calculadora de IMC",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh_sharp),
              onPressed: _resetarCampos,
            ),
          ]),
      body: SingleChildScrollView(
        child: Form(
          key: _chaveFormulario,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 150,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                      )),
                  controller: controllerPeso,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira seu Peso!";
                    }
                  },
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 20.0,
                        )),
                    controller: controllerAltura,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira seu Altura!";
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Container(
                    height: 80.0,
                    width: 250.0,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_chaveFormulario.currentState!.validate()) {
                            _calcular();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,

                        ),
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        )),
                  ),
                ),
                Text(
                  _informacoes,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
