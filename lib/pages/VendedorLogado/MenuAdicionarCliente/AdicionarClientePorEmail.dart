import 'package:flutter/material.dart';
import 'package:migrou_app/componentes/botos_home.dart';
import 'package:migrou_app/pages/VendedorLogado/InfoPageClienteADD.dart';
import 'package:migrou_app/utils/definicoes.dart';

var emailUser;

class AddPorEmail extends StatefulWidget {
  @override
  _AddPorEmailState createState() => _AddPorEmailState();
}

class _AddPorEmailState extends State<AddPorEmail> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _myController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Localizar por e-mail"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    "Digite o e-mail do cliente cadastrado no aplicativo",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _myController,
                  decoration: InputDecoration(
                    labelText: "Digite o e-mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    emailUser = _myController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfoClienteLocaliado()),
                    );
                  });
                },
                child: MyCustomButton(
                    color: Constantes.customColorBlue, text: "Procurar"))
          ],
        ),
      ),
    );
  }
}
