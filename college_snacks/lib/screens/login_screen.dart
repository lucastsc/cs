import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

  AnimationController animationController;
  Animation<double> animatedButton;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    );

    animatedButton = Tween(begin: 360.0, end: 40.0).
      animate(CurvedAnimation(parent: animationController, curve: Interval(0.0, 0.150)));
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
                padding: EdgeInsets.only(top: 4.0, right: 6.0),
                onPressed: (){
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignUpScreen())
                  ); // A diferença para o pushReplacement é que ele volta para a página principal em que não tenha opção de voltar
                },
                child: Text("Criar conta", style: TextStyle(fontSize: 15.0, color: Colors.white),)),
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model){
              if(model.isLoading) return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),);
              return Form(
                  key: _key,
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: "E-mail"
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value){
                                  if(value.isEmpty || !value.contains("@")) return "E-mail inválido!";
                                },
                                controller: _emailController,
                              ),
                              SizedBox(height: 16.0,),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Senha"
                                ),
                                obscureText: true, // Assim o texto fica escondido
                                validator: (value){
                                  if(value.isEmpty || value.length < 6) return "Senha Inválida";
                                },
                                controller: _passController,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: (){

                                    },
                                    child: Text(
                                      "Esqueci minha senha",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(),
                                    )
                                ),
                              ),
                              SizedBox(height: 100.0,),
                            ],
                          ),
                          AnimatedBuilder(
                              animation: animationController,
                              builder: (context, child){
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 50.0),
                                  child: InkWell(
                                    onTap: () async{
                                      if(_key.currentState.validate()){
                                        animationController.forward();
                                        Future.delayed(Duration(milliseconds: 1500)).then((T){
                                          model.signIn(
                                              email: _emailController.text,
                                              pass: _passController.text,
                                              onSuccess: _onSuccess,
                                              onFailed: _onFailed
                                          );
                                        });
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: animatedButton.value,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(Radius.circular(30.0))
                                      ),
                                      child: _buildInside(context)
                                    ),
                                  ),
                                );
                              }
                          )
                        ],
                      )
                    ],
                  )
              );
            }
        )
    );
  }

  Widget _buildInside(BuildContext context){
    if(animatedButton.value > 75) return Text("Entrar", style: TextStyle(fontSize: 18.0, color: Colors.white),);
    else{
      return Padding(
        padding: EdgeInsets.all(2.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2.0,
        ),
      );
    }
  }

  void _onSuccess(){
    Navigator.of(context).pop(); // Volta para a tela principal
  }

  void _onFailed(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("E-mail ou senha incorretos"),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
    ));
  }

}
