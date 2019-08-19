import 'package:college_snacks/datas/card_colors.dart';
import 'package:college_snacks/models/card_model.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:college_snacks/blocs/bloc_provider.dart';

class CardBloc implements BlocBase{
  final _cardsCollection = BehaviorSubject<List<CardResults>>(); // Our Stream Controller, but using nxdart plugin
  List<CardResults> _cardResults;

  // To receive data on the stream
  Stream<List<CardResults>> get cardList => _cardsCollection.stream;

  void initialData()async{ // Function to load data from a Json File in another directory
    var initialData = await rootBundle.loadString('data/initialData.json');
    var decodedJson =  json.decode(initialData);
    _cardResults = CardModel.fromJson(decodedJson).cardResults;
    for(int i = 0; i<_cardResults.length; i++){
      _cardResults[i].cardColor = CardColor.baseColors[i];
    }
    _cardsCollection.sink.add(_cardResults);
  }

  CardBloc(){
    initialData();
  }

  void addCardToList(CardResults newCard){
    _cardResults.add(newCard);
    _cardsCollection.sink.add(_cardResults);
  }

  void dispose(){
    _cardsCollection.close();
  }

}

final cardListBloc = new CardBloc();