import 'package:flutter/material.dart';
import 'package:my_nutri/src/models/http.dart';
import 'package:intl/intl.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final format = DateFormat("dd/MM/yyyy");
  TextEditingController nameController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nascimentoController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  cadastrarUser() async {
    var result = await http_post("cadastro", {
      "name": nameController.text,
      "email": emailController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(

        title: Text(
          "Cadastro",
          textAlign: TextAlign.left,
        ),
      ),*/
      body: Form(key: _formKey, autovalidate: _validate, child: _dados()),
    );
  }

  Widget _dados() {
    return Container(
      //margin: EdgeInsets.only(left: 10, right: 10),
      child: ListView(
        children: <Widget>[
          menuBar(),
          body(),
        ],
      ),
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  padding:
                      EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          height: 0,
                        ),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        hintText: "Nome",
                      ),
                      validator: _validarNome,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: snameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        hintText: "Sobrenome",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //width: MediaQuery.of(context).size.width / 1.1,
            height: 50,
            padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  height: 0,
                ),
                border: InputBorder.none,
                icon: Icon(
                  Icons.mail,
                  color: Colors.grey,
                ),
                hintText: "E-mail",
              ),
              validator: _validarEmail,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //width: MediaQuery.of(context).size.width / 2.2,
            height: 45,
            padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
            child: TextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: senhaController,
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  height: 0,
                ),
                border: InputBorder.none,
                icon: Icon(
                  Icons.vpn_key,
                  color: Colors.grey,
                ),
                hintText: "Senha",
              ),
              validator: _validarCelular,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //width: MediaQuery.of(context).size.width / 2.2,
            height: 45,
            padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: nascimentoController,
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  height: 0,
                ),
                border: InputBorder.none,
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                ),
                hintText: "Nascimento",
              ),
              validator: _validarEmail,
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());

                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  nascimentoController.text =
                      DateFormat('dd/MM/yyy').format(date);
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //width: MediaQuery.of(context).size.width / 2.2,
            height: 45,
            padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              controller: telController,
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  height: 0,
                ),
                border: InputBorder.none,
                icon: Icon(
                  Icons.phone,
                  color: Colors.grey,
                ),
                hintText: "Telefone",
              ),
              validator: _validarCelular,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  height: 45,
                  padding:
                      EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: nameController,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          height: 0,
                        ),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.height,
                          color: Colors.grey,
                        ),
                        hintText: "Altura",
                      ),
                      validator: (altura) =>
                          altura.length == 0 ? 'Informe sua altura' : null,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    //width: MediaQuery.of(context).size.width / 2.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: pesoController,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          height: 0,
                        ),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.bar_chart_sharp,
                          color: Colors.grey,
                        ),
                        hintText: "Peso",
                      ),
                      validator: (peso) =>
                          peso.length == 0 ? 'Informe seu peso' : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 60,
            alignment: Alignment.center,
            //color: Colors.green,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
              onPressed: _validCadastro,
              child: Text(
                "Cadastrar",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF004F0D), Color(0xFF00AD1A)],
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.person,
              size: 90,
              color: Colors.white,
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32, right: 32),
              child: Text(
                'Cadastro',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _validarNome(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  String _validarNacimento(DateTime value) {
    if (value == null) {
      return "Informe a data de nascimento";
    }
    return null;
  }

  String _validarCelular(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o celular";
    } else if (value.length != 10) {
      return "O celular deve ter 10 dígitos";
    } else if (!regExp.hasMatch(value)) {
      return "O número do celular so deve conter dígitos";
    }
    return null;
  }

  String _validarEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  _validCadastro() {
    if (_formKey.currentState.validate()) {
      // Sem erros na validação
      _formKey.currentState.save();
      cadastrarUser();
    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
    }
  }
}
