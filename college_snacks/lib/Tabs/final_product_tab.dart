import 'package:college_snacks/datas/product_data.dart';
import 'package:flutter/material.dart';

class FinalProductTab extends StatefulWidget {

  ProductData productData;
  FinalProductTab(this.productData);

  @override
  _FinalProductTabState createState() => _FinalProductTabState();
}

class _FinalProductTabState extends State<FinalProductTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.productData.url)
                      )
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.productData.description)
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Adicionar ao carrinho"),
                  onPressed: (){},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
