import 'package:college_snacks/Tabs/card_settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:college_snacks/Widgets/add_card_front.dart';
import 'package:college_snacks/blocs/card_manage_bloc.dart';
import 'package:college_snacks/blocs/bloc_provider.dart';

class CardWallet extends StatefulWidget {
  @override
  _CardWalletState createState() => _CardWalletState();
}

class _CardWalletState extends State<CardWallet> with TickerProviderStateMixin{
  
  AnimationController rotateController;
  AnimationController opacityController;
  Animation<double> animation;
  Animation<double> opacityAnimation;


  @override
  void didChangeDependencies() {

    final CardManageBloc bloc = BlocProvider.of<CardManageBloc>(context);
    rotateController = AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 300)
    );
    opacityController = AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 2000)
    );

    CurvedAnimation curvedAnimation = new CurvedAnimation(
        parent: opacityController, curve: Curves.fastOutSlowIn
    );

    animation = Tween(begin: -2.0, end: -3.15).animate(rotateController);
    opacityAnimation =  Tween(begin: 0.0, end: 1.0).animate(curvedAnimation);

    opacityAnimation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        bloc.saveCard();
        Navigator.push(context, MaterialPageRoute(builder: (context) => CardSettings()));
      }
    });

    rotateController.forward();
    opacityController.forward();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
   rotateController.dispose();
   opacityController.dispose();
   super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Carteira'),
        leading: Icon(Icons.arrow_back),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: AnimatedBuilder(
                  animation: animation,
                  child: Container(
                    width: _screenSize.width / 1.4,
                    height: _screenSize.height / 1.8,
                    child: CardFront(rotatedTurnsValue: -3),
                  ),
                builder: (context, _widget){
                  return Transform.rotate(
                    angle: animation.value,
                    child: _widget,
                  );
                }
              ),
            ),
            SizedBox(height: 30.0,),
            CircularProgressIndicator(
              strokeWidth: 6.0,
              backgroundColor: Colors.lightBlue,
            ),
            SizedBox(height: 10.0,),
            FadeTransition(
              opacity: opacityAnimation,
              child: Text('Cartão adicionado!',
                style: TextStyle(color: Colors.lightBlue, fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
