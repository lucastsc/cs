import 'dart:async';
import 'package:college_snacks/blocs/card_bloc.dart';
import 'package:college_snacks/datas/card_colors.dart';
import 'package:college_snacks/models/card_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:college_snacks/blocs/validators.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class CardManageBloc extends BlocBase with Validators{
  //Bloc to manage cards (e.g add a new one)

  final _cardHolderName = BehaviorSubject<String>();
  final _cardNumber = BehaviorSubject<String>();
  final _cardMonth = BehaviorSubject<String>();
  final _cardYear = BehaviorSubject<String>();
  final _cardCvv = BehaviorSubject<String>();
  final _cardType = BehaviorSubject<String>();
  final _cardColorIndexSelected = BehaviorSubject<int>(seedValue: 0);

  final _cardColors = BehaviorSubject<List<CardColorModel>>();

  // Add data to stream
  Sink get changeCardHolderName => _cardHolderName.sink;
  Sink get changeCardNumber => _cardNumber.sink;
  Sink get changeCardMonth => _cardMonth.sink;
  Sink get changeCardYear => _cardYear.sink;
  Sink get changeCardCvv => _cardCvv.sink;
  Function(String) get selectCardType => _cardType.sink.add;

  // Retrieve data from Stream
  Stream<String> get cardHolderName => _cardHolderName.stream.transform(validateCardHolderName);
  Stream<String> get cardNumber => _cardNumber.stream.transform(validateCardNumber);
  Stream<String> get cardMonth => _cardMonth.stream.transform(validateCardMonth);
  Stream<String> get cardYear => _cardYear.stream.transform(validateCardYear);
  Stream<String> get cardCvv => _cardCvv.stream.transform(validateCardVerificationValue);
  Stream<String> get cardType => _cardType.stream;
  Stream<int> get cardColorIndexSelected => _cardColorIndexSelected.stream;
  Stream<List<CardColorModel>> get cardColorList => _cardColors.stream;
  Stream<bool> get saveCardValid => Observable.combineLatest5(cardHolderName, cardNumber,
    cardMonth, cardYear, cardCvv, (ch, cn, cm, cy, cv) => true);

  void saveCard(){
    final newCard = CardResults(
      cardHolderName: _cardHolderName.value,
      cardNumber: _cardNumber.value,
      cardMonth: _cardMonth.value,
      cardYear: _cardYear.value,
      cardCvv: _cardCvv.value,
      cardColor: CardColor.baseColors[_cardColorIndexSelected.value],
      cardType: _cardType.value
    );
    cardListBloc.addCardToList(newCard);
  }

  void selectCardColor(int colorIndex){
    CardColor.cardColors.forEach((element) => element.isSelected = false);
    CardColor.cardColors[colorIndex].isSelected = true;
    _cardColors.sink.add(CardColor.cardColors);
    _cardColorIndexSelected.sink.add(colorIndex);
  }

  void dispose(){
    _cardType.close();
    _cardHolderName.close();
    _cardNumber.close();
    _cardMonth.close();
    _cardYear.close();
    _cardCvv.close();
    _cardColorIndexSelected.close();
    _cardColors.close();
  }

}

final cardManage = new CardManageBloc();