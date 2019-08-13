import 'package:college_snacks/blocs/card_manage_bloc.dart';
import 'package:college_snacks/datas/card_colors.dart';
import 'package:flutter/material.dart';

class CardFront extends StatelessWidget {
  final int rotatedTurnsValue; // to set card horizontal or vertical
  CardFront({this.rotatedTurnsValue});

  @override
  Widget build(BuildContext context) {

    final _cardNumber = Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder<String>(
            stream: cardManage.cardNumber, // Se der errado, o erro veio daqui!!!!!!!!!!
            builder: (context, snapshot){
              return snapshot.hasData ? _formatCardNumber(snapshot.data) :
              _formatCardNumber('0000000000000000');
            },
          )
        ],
      ),
    );

    final _cardLastNumber = Padding(
      padding: const EdgeInsets.only(top: 1.0, left: 35.0),
      child: StreamBuilder<String>(
        stream: cardManage.cardNumber, // Se der errado, o erro veio daqui!!!!!!!!!!
        builder: (context, snapshot){
          return Text(
            snapshot.hasData && snapshot.data.length >= 15 ?
                snapshot.data.replaceAll(RegExp(r'\s+\b|\b\s'), '').substring(12) :
                '0000',
            style: TextStyle(color: Colors.white, fontSize: 8.0),
          );
        },
      )
    );

    final _cardValidThru = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Valid',
                style: TextStyle(color: Colors.white, fontSize: 8.0),
              ),
              Text(
                'Thru',
                style: TextStyle(color: Colors.white, fontSize: 8.0),
              )
            ],
          ),
          SizedBox(width: 5.0,),
          StreamBuilder<String>(
            stream: cardManage.cardMonth,
            builder: (context, snapshot){
              return Text(
                snapshot.hasData ? snapshot.data : '00',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              );
            },
          ),
          StreamBuilder<String>(
            stream: cardManage.cardYear,
            builder: (context, snapshot){
              return Text(
                snapshot.hasData && snapshot.data.length > 2 ?
                    '/${snapshot.data.substring(2)}' : '/00',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              );
            },
          )
        ],
      ),
    );

    final _cardOwner = Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 44.0),
      child: StreamBuilder<String>(
        stream: cardManage.cardHolderName,
        builder: (context, snapshot) => Text(
          snapshot?.data ?? 'NOME NO CARTÃO',
          style: TextStyle(color: Colors.white, fontSize: 18.0)
        ),
      ),
    );

    final _cardLogo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25.0, right: 45.0),
            child: Image(
              image: AssetImage('assets/visa_logo2.png'),
              width: 65.0,
              height: 32.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 45.0),
            child: StreamBuilder<String>(
              stream: cardManage.cardType,
              builder: (context, snapshot){
                return Text(
                  snapshot.hasData ? snapshot.data : '',
                  style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400),
                );
              },
            ),
          )
        ],
    );

    final _cardChip = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 35.0,
            width: 50.0,
            child: AspectRatio(
              aspectRatio: 16/9,
              child: Image(
                image: AssetImage("assets/sEkxFN3I.png"),
              ),
            ),
          ),
          SizedBox(width: 55.0,),
          SizedBox(width: 50.0,),
          SizedBox(width: 50.0,)
        ],
      ),
    );

    return StreamBuilder<int>(
      stream: cardManage.cardColorIndexSelected,
      initialData: 0,
      builder: (context, snapshot){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: CardColor.baseColors[snapshot.data]
          ),
          child: RotatedBox(
            quarterTurns: rotatedTurnsValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _cardLogo,
                _cardChip,
                _cardNumber,
                _cardLastNumber,
                _cardValidThru,
                _cardOwner
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _formatCardNumber(String cardNumber){
    cardNumber = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    List<Widget> numberList = new List<Widget>();
    var counter = 0;
    numberList.add(SizedBox(width: 15.0,));
    for(var i = 0; i<cardNumber.length; i++){
      counter += 1;
      numberList.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              cardNumber[i],
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
      );
      if(counter == 4){
        counter = 0;
        numberList.add(SizedBox(width: 22.0,));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numberList,
    );
  }

}
