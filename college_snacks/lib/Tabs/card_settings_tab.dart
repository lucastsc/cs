import 'package:college_snacks/Tabs/add_card_tab.dart';
import 'package:college_snacks/Widgets/card_images.dart';
import 'package:flutter/material.dart';

class CardSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Minha Carteira"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  AddCardTab()));
            }
          )
        ],
      ),
      body: Center(child: CardImages(),)
    );
  }
}
