import 'package:college_snacks/blocs/card_bloc.dart';
import 'package:college_snacks/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return StreamBuilder<List<CardResults>>(
      stream: cardListBloc.cardList,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),),);
        }
        else{
          return SizedBox(
            height: _screenSize.height * 0.8,
            child: Swiper(
              itemCount: snapshot.data.length,
              itemWidth: _screenSize.width * 0.75,
              itemHeight: _screenSize.height * 0.62,
              layout: SwiperLayout.STACK,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
                return CardFrontStyle(
                  card: snapshot.data[index]
                );
              },
            ),
          );
        }
      }
    );
  }
}

class CardFrontStyle extends StatelessWidget {

  final CardResults card;
  CardFrontStyle({this.card});

  @override
  Widget build(BuildContext context) {

    final _cardLogo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 25.0, right: 52.0),
          child: Image(
            image: AssetImage("assets/visa_logo2.png"),
            width: 65.0,
            height: 32.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 52.0),
          child: Text(
            card.cardType != null ? card.cardType : 'CREBITO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w400
            ),
          ),
        )
      ],
    );

    final _cardNumber = Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildDots()
      ],
    ),
  );

    final _cardValidThru = Padding(
      padding: EdgeInsets.only(top: 8.0),
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
          Text(
            (card.cardMonth != null && card.cardYear != null) ? "${card.cardMonth}/${card.cardYear.substring(2 )}" : '02/2024',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          )
        ],
      ),
    );

    final _cardOwner = Padding(
      padding: EdgeInsets.only(top: 15.0, left: 35.0),
      child: Text(
        card.cardHolderName != null ? card.cardHolderName.toUpperCase() : 'DEU RUIM IRMAO',
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: card.cardColor
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _cardLogo,
            _cardChip,
            _cardNumber,
            _cardValidThru,
            _cardOwner
          ],
        ),
      ),
    );
  }

  Widget _buildDots(){
    List<Widget> dotList = new List<Widget>();
    var counter = 0;

    for(var i = 0; i<12; i++){
      counter++;
      dotList.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Container(
            height: 6.0,
            width: 6.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
          ),
        )
      );
      if(counter == 4){
        counter = 0;
        dotList.add(SizedBox(width: 30.0,));
      }
    }
    dotList.add(_buildNumbers());
    return Row(children: dotList,);
  }
  
  Widget _buildNumbers(){
    return Text(
        card.cardNumber!=null? card.cardNumber.substring(12) : '0000',
      style: TextStyle(color: Colors.white),
    );
  }
}

