import 'dart:async';
import 'package:college_snacks/blocs/card_bloc.dart';
import 'package:college_snacks/datas/card_colors.dart';
import 'package:college_snacks/models/card_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:college_snacks/blocs/validators.dart';
import 'package:college_snacks/blocs/bloc_provider.dart';

class CardManageBloc with Validators implements BlocBase{
  //Bloc to manage cards (e.g add a new one)

  BehaviorSubject<String> _cardHolderName = BehaviorSubject<String>();
  BehaviorSubject<String> _cardNumber = BehaviorSubject<String>();
  BehaviorSubject<String> _cardMonth = BehaviorSubject<String>();
  BehaviorSubject<String> _cardYear = BehaviorSubject<String>();
  BehaviorSubject<String> _cardCvv = BehaviorSubject<String>();
  BehaviorSubject<String> _cardType = BehaviorSubject<String>();
  BehaviorSubject<int> _cardColorIndexSelected = BehaviorSubject<int>(seedValue: 6);

  BehaviorSubject<List<CardColorModel>> _cardColors = BehaviorSubject<List<CardColorModel>>();

  // Add data to stream
  Function(String) get changeCardHolderName => _cardHolderName.sink.add;
  Function(String) get changeCardNumber => _cardNumber.sink.add;
  Function(String) get changeCardMonth => _cardMonth.sink.add;
  Function(String) get changeCardYear => _cardYear.sink.add;
  Function(String) get changeCardCvv => _cardCvv.sink.add;
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
    unformatCardNumber();
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

  void unformatCardNumber(){ // Function to revert the cardNumber format
    _cardNumber.value = _cardNumber.value.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
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