import 'package:flutter/material.dart';
import 'package:migrou_app/pages/vendedor_logado/InfoPageClienteADD.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          FlatButton(
            height: 30,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                emailUser = _myController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfoClienteLocaliado()),
                );
              });
            },
            child: Text(
              "Buscar Cliente",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}