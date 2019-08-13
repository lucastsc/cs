import 'package:college_snacks/Widgets/card_wallet.dart';
import 'package:flutter/material.dart';
import 'package:college_snacks/Widgets/flip_card.dart';
import 'package:college_snacks/Widgets/add_card_back.dart';
import 'package:college_snacks/Widgets/add_card_front.dart';
import 'package:college_snacks/datas/card_colors.dart';
import 'package:college_snacks/helpers/formatters.dart';
import 'package:college_snacks/blocs/card_bloc.dart';
import 'package:college_snacks/blocs/card_manage_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:college_snacks/models/card_model.dart';

class CardCreate extends StatefulWidget{
  @override
  _CardCreateState createState() => _CardCreateState();
}

class _CardCreateState extends State<CardCreate> {
  final GlobalKey<FlipCardState> animatedStateKey = new GlobalKey<FlipCardState>();

  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async{
    animatedStateKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {

    final _creditCard = Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Card(
        color: Colors.grey[100],
        elevation: 0.0,
        margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child: FlipCard(
          key: animatedStateKey,
          front: CardFront(rotatedTurnsValue: 0,),
          back: CardBack(),
        ),
      ),
    );

    final _cardHolderName = StreamBuilder<String>(
      stream: cardManage.cardHolderName,
      builder: (context, snapshot){
        return TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: (data){
            cardManage.changeCardHolderName.add(data);
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hintText: 'Nome do proprietário',
            errorText: snapshot.error
          ),
        );
      },
    );

    final _cardNumber = Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: StreamBuilder<String>(
        stream: cardManage.cardNumber,
        builder: (context, snapshot){
          return TextField(
            onChanged: (data){
              cardManage.changeCardNumber.add(data);
            },
            keyboardType: TextInputType.text,
            maxLength: 19,
            maxLengthEnforced: true,
            inputFormatters: [
              MaskedTextInputFormatter(
                  mask: 'xxxx xxxx xxxx xxxx',
                  separator: ' ',
              )
            ],
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Número do cartão',
                errorText: snapshot.error
            ),
          );
        },
      ),
    );

    final _cardMonth = StreamBuilder<String>(
      stream: cardManage.cardMonth,
      builder: (context, snapshot){
        return Container(
          width: 65.0,
          child: TextField(
            onChanged: (data){
              cardManage.changeCardMonth.add(data);
            },
            keyboardType: TextInputType.number,
            maxLength: 2,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'MM',
              counterText: '',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );

    final _cardYear = StreamBuilder<String>(
      stream: cardManage.cardYear,
      builder: (context, snapshot){
        return Container(
          width: 100.0,
          child: TextField(
            onChanged: (data){
              cardManage.changeCardYear.add(data);
            },
            keyboardType: TextInputType.number,
            maxLength: 4,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'YYYY',
              counterText: '',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );

    final _cardVerificationValue = StreamBuilder<String>(
      stream: cardManage.cardCvv,
      builder: (context, snapshot){
        return Container(
          width: 65.0,
          child: TextField(
            focusNode: _focusNode,
            onChanged: (data){
              cardManage.changeCardCvv.add(data);
            },
            keyboardType: TextInputType.number,
            maxLength: 3,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'CVV',
              counterText: '',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );

    final _saveCard = StreamBuilder(
      stream: cardManage.saveCardValid,
      builder: (context, snapshot){
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          child: RaisedButton(
            child: Text('Salvar cartão', style: TextStyle(color: Colors.white),),
            color: Colors.lightBlue,
            onPressed: snapshot.hasData ? (){
              var blocProviderCardWallet = BlocProvider(
                child: CardWallet(),
                bloc: CardManageBloc(),
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) => blocProviderCardWallet));
            } : null
          ),
        );
      },
    );

    return Scaffold(
       appBar: AppBar(
         title: Text('Adicionar cartão'),
         leading: IconButton(
           icon: Icon(Icons.arrow_back),
           onPressed: (){
             Navigator.of(context).pop();
           },
         ),
       ),
      backgroundColor: Colors.grey[200],
      body: ListView(
        itemExtent: 750.0,
        padding: EdgeInsets.only(top: 10.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
               flex: 3,
               child: _creditCard,
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 8.0,),
                      _cardHolderName,
                      _cardNumber,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _cardMonth,
                          SizedBox(width: 16.0,),
                          _cardYear,
                          SizedBox(width: 16.0,),
                          _cardVerificationValue
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      cardColors(cardManage),
                      SizedBox(height: 10.0,),
                      _saveCard
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget cardColors(CardManageBloc bloc){
    final dotSize = (MediaQuery.of(context).size.width - 220) / CardColor.baseColors.length;

    List<Widget> dotList = new List<Widget>();

    for(var i = 0; i < CardColor.baseColors.length; i++){
      dotList.add(
        StreamBuilder<List<CardColorModel>>(
          stream: bloc.cardColorList,
          builder: (context, snapshot){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () => cardManage.selectCardColor(i),
                child: Container(
                  child: snapshot.hasData ? snapshot.data[i].isSelected ?
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12.0,
                      ) :
                      Container()
                      : Container(),
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: CardColor.baseColors[i],
                    shape: BoxShape.circle
                  ),
                ),
              ),
            );
          },
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dotList,
    );
  }
}
