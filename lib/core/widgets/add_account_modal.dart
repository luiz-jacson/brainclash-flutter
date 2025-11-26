import 'package:flutter/material.dart';

class AddAccountModal extends StatefulWidget {
  const AddAccountModal({super.key});

  @override
  State<AddAccountModal> createState() => _AddAccountModalState();
}

class _AddAccountModalState extends State<AddAccountModal> {
  String _accountType = "AMBROSIA";
  TextEditingController _nome = TextEditingController();
  TextEditingController _sobrenome = TextEditingController();
  bool isLoading = false;

  onButtonCancelClicked() {
    if(!isLoading){
    Navigator.pop(context);
    }
  }

  onButtonSendClicked() {
    setState(() {
      isLoading = true;
    });
    String nome = _nome.text;
    String sobrenome = _sobrenome.text;
    if(!isLoading){
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width * 1,
      padding: EdgeInsets.only(
        left: 32,
        right: 32,
        top: 32,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset('assets/images/icon_add_account.png'),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text(
                      "Adicionar nova conta",
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text(
                      "Preencha os dados abaixo:",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nome,
                decoration: InputDecoration(labelText: "Nome"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _sobrenome,
                decoration: InputDecoration(labelText: "Último Nome"),
              ),
            ),
            SizedBox(height: 32),
            DropdownButton<String>(
              isExpanded: true,
              value: _accountType,
              items: const [
                DropdownMenuItem(value: "AMBROSIA", child: Text("AMBROSIA")),
                DropdownMenuItem(
                  value: "BRIGADEIRA",
                  child: Text("BRIGADEIRA"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _accountType = value!;
                });
              },
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed:(isLoading)? null : () {
                        onButtonSendClicked();
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: onButtonSendClicked,
                      child: (isLoading) ? CircularProgressIndicator() :Text(
                        "Adicionar",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
