import 'package:college_snacks/models/card_model.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class CardBloc{
  final _cardsCollection = BehaviorSubject<List<CardResults>>(); // Our Stream Controller, but using nxdart plugin
  List<CardResults> _cardResults;

  // To receive data on the stream
  Stream<List<CardResults>> get cardList => _cardsCollection.stream;

  void initialData()async{ // Function to load data from a Json File in another directory
    var initialData = await rootBundle.loadString('data/initialData.json');
    var decodedJson =  json.decode(initialData);
    _cardResults = CardModel.fromJson(decodedJson).cardResults;
    _cardsCollection.sink.add(_cardResults);
  }

  CardBloc(){
    initialData();
  }

  void dispose(){
    _cardsCollection.close();
  }

}

final cardListBloc = new CardBloc();