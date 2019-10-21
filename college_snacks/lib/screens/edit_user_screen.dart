import 'package:college_snacks/Widgets/user_profile_picture.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:flutter/material.dart';

class UserEditScreen extends StatefulWidget {
  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {

  GlobalKey<FormState> _key = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserModel model = UserModel.of(context);
    return Form(
        key: _key,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.close), onPressed: (){Navigator.of(context).pop();}),
            title: Text("Editar cadastro"),
          ),
          body: ListView(
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
                initialValue: model.userData["name"],
                validator: (value){
                  if(!value.isEmpty) return "Insira um nome válido";
                },
                decoration: InputDecoration(
                  labelText: "Nome",
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                initialValue: model.userData["lastName"],
                validator: (value){
                  if(!value.isEmpty) return "Insira um sobrenome válido";
                },
                decoration: InputDecoration(
                  labelText: "Sobrenome",
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                initialValue: model.userData["email"],
                validator: (value){
                  if(!(value.isEmpty) || !(value.contains("@"))) return "Insira um email válido";
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
                validator: (value){
                  if(!(value.isEmpty) || !(value.contains("@"))) return "Insira um email válido";
                },
                decoration: InputDecoration(
                  labelText: "Senha",
                  fillColor: Colors.grey
                ),
              ),
              SizedBox(height: 40.0,),
              SizedBox(
                height: 44.0,
                child: RaisedButton(
                  child: Text("Salvar", style: TextStyle(color: Colors.white, fontSize: 16.0),),
                  color: Theme.of(context).primaryColor,
                  onPressed: (){} // TODO: implement button functionality and update user data on submitted
                ),
              )
            ],
          ),
        )
    );
  }
}

