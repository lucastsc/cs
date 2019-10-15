import 'dart:async';

class Validators{
  final validateCardHolderName = StreamTransformer<String, String>.fromHandlers(
    handleData: (cardHolderName, sink){
      RegExp('[a-zA-Z]').hasMatch(cardHolderName) ? sink.add(cardHolderName.toUpperCase()) : sink.addError('Insira um nome válido');
    }
  );

  final validateCardNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardNumber, sink){
        RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$').
        hasMatch(cardNumber.replaceAll(new RegExp(r"\s+\b|\b\s"), "")) ?
            sink.add(cardNumber) : sink.addError('Insira um número de cartão válido');
            print(cardNumber);
      }
  );

  final validateCardMonth = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardMonth, sink){
        if(cardMonth.isNotEmpty &&
            int.parse(cardMonth) > 0 &&
            int.parse(cardMonth) < 13){
          sink.add(cardMonth);
        }else{
          sink.addError('Err. campo mês');
        }
      }
  );

  final validateCardYear = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardYear, sink){
        if(cardYear.isNotEmpty &&
            int.parse(cardYear) > 2018 &&
            int.parse(cardYear) < 2029){
          sink.add(cardYear);
        }else{
          sink.addError('Ano inválido');
        }
      }
  );

  final validateCardVerificationValue = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardCvv, sink){
        if(cardCvv.length > 2){
          sink.add(cardCvv);
        }else{
          sink.addError('Código verificador inválido');
        }
      }
  );
}