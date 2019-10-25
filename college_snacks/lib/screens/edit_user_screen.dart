import 'dart:math';

import 'package:college_snacks/Widgets/user_profile_picture.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserEditScreen extends StatefulWidget {
  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {

  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    UserModel model = UserModel.of(context);
    String _name = model.userData["name"];
    String _lastName = model.userData["lastName"];
    String _email = model.userData["email"];
    return Form(
        key: _key,
        child: Scaffold(
          key: _scaffKey,
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.close), onPressed: (){Navigator.of(context).pop();}),
            title: Text("Editar cadastro"),
          ),
          body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model){
              if(model.isLoggedIn() && model.isLoading) return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),);
              else return ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        child: UserProfilePicture(80.0, 80.0),
                        onTap: (){},
                      ),
                      SizedBox(width: 10.0,),
                      Text("Toque para alterar\n a foto de perfil", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic))
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: _name,
                    onFieldSubmitted: (text){
                      setState(() {
                        _name = text;
                      });
                    },
                    validator: (value){
                      if(value.isEmpty) return "Insira um nome válido";
                    },
                    decoration: InputDecoration(
                      labelText: "Nome",
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: _lastName,
                    onFieldSubmitted: (text){
                      setState(() {
                        _lastName = text;
                      });
                    },
                    validator: (value){
                      if(value.isEmpty) return "Insira um sobrenome válido";
                    },
                    decoration: InputDecoration(
                      labelText: "Sobrenome",
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: _email,
                    onFieldSubmitted: (text){
                      setState(() {
                        _email = text;
                      });
                    },
                    validator: (value){
                      if((value.isEmpty) || !(value.contains("@"))) return "Insira um email válido";
                    },
                    decoration: InputDecoration(
                      labelText: "E-mail",
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    enabled: false,
                    obscureText: true,
                    initialValue: model.userData["name"],
                    decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(color: Colors.grey)
                    ),
                  ),
                  SizedBox(height: 40.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                        child: Text("Salvar", style: TextStyle(color: Colors.white, fontSize: 16.0),),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async{
                          if(_key.currentState.validate()){
                            Map<String,dynamic> userData = {
                              "name": _name,
                              "lastName": _lastName,
                              "email": _email,
                              "stage": 0
                            };
                            print(userData["name"]);
                            await model.updateUser(userData, _onSuccess).catchError((e){
                              _onFail();
                            });
                          }
                        }
                    ),
                  )
                ],
              );
              },
          )
        )
    );
  }

  void _onSuccess() {
    _scaffKey.currentState.showSnackBar(SnackBar(content: Text("Dados atualizados com sucesso!"), duration: Duration(seconds: 2),));
    Future.delayed(Duration(seconds: 2)).then((exit){
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffKey.currentState.showSnackBar(SnackBar(content: Text("Opss, ocorreu um problema. Tente novamente!"), duration: Duration(seconds: 2),));
  }

}

/*

 */