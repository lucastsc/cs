import 'package:college_snacks/blocs/card_bloc.dart';
import 'package:college_snacks/blocs/card_manage_bloc.dart';
import 'package:college_snacks/screens/card_create_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class AddCardTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final _buildTextInfo = Padding(
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      child: Text.rich(
        TextSpan(
          text: 'Você pode adicionar Gift Cards com um saldo específico a sua carteira. Quando o saldo atingir R\$: ${0.0}, o cartão desaparecerá automaticamente.',
          style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
          children: <TextSpan>[
            TextSpan(
              text: 'Saiba mais.',
              style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold)
            )
          ]
        ),
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.clear), onPressed: (){Navigator.of(context).pop();}),
        title: Text("Adicionar pagamento"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildButton(Colors.lightBlue, 'Credit Card', Colors.white, context),
            _buildButton(Colors.grey[100], 'Debit Card', Colors.grey[600], context),
            _buildButton(Colors.grey[100], 'Gift Card', Colors.grey[600], context),
            _buildTextInfo
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      Color buttonColor,
      String buttonText,
      Color textColor,
      BuildContext context){

    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child: RaisedButton(
        color: buttonColor,
        elevation: 1.0,
        onPressed: (){
          var blocProviderCardCreate = BlocProvider(
            child: CardCreate(),
            bloc: CardManageBloc(),
          );
          blocProviderCardCreate.bloc.selectCardType(buttonText);
          Navigator.push(context, MaterialPageRoute(builder: (context) => blocProviderCardCreate));// STOPPED HERE
        },
        child: Text(buttonText, style: TextStyle(color: textColor),),
      ),
    );
  }
}
