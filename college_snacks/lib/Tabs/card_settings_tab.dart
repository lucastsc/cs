import 'package:college_snacks/Widgets/card_images.dart';
import 'package:flutter/material.dart';

class CardSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Carteira"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){}
          )
        ],
      ),
      body: CardImages(),
    );
  }
}
