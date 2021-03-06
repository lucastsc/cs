import 'package:college_snacks/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),
            );
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Nome"),
                  validator: (text) {
                    if (text.isEmpty) return "Nome Inválido!";
                  },
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(hintText: "Sobrenome"),
                  validator: (text) {
                    if (text.isEmpty) return "Sobrenome Inválido!";
                  },
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (text) {
                    if (text.isEmpty || !(text.contains("@"))) return "E-mail Inválido!";
                  },
                ),
                SizedBox(height: 10.0,),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Senha"),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválida!";
                  },
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Confirme sua senha"),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválida";
                    if (_confirmPasswordController.text != _passwordController.text)
                      return "As senhas digitadas não são iguais!";
                  },
                ),
                SizedBox(height: 30.0,),
                SizedBox(
                  height: 40.0,
                  child: RaisedButton(
                    child: Text(
                      "Criar Conta",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "lastName": _lastNameController.text,
                          "stage" : 0
                        };
                        model.signUp(
                            userData: userData,
                            password: _passwordController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffKey.currentState.showSnackBar(SnackBar(content: Text("Usuário criado com sucesso!"), duration: Duration(seconds: 2),));
    Future.delayed(Duration(seconds: 2)).then((exit){
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffKey.currentState.showSnackBar(SnackBar(content: Text("Usuário criado com sucesso!"), duration: Duration(seconds: 2),));
  }
}
