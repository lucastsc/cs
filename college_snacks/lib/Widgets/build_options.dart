import 'package:flutter/material.dart';

class BuildOptions extends StatefulWidget {

  final String option;
  BuildOptions(this.option);

  @override
  _BuildOptionsState createState() => _BuildOptionsState(option);
}

class _BuildOptionsState extends State<BuildOptions> {

  final String option;
  int quantity = 0;
  _BuildOptionsState(this.option);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(option),
          Row(
            children: <Widget>[
              Container(//container containing the remove button
                height: 40.0,
                width: 30.0,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: quantity == 0 ? Icon(Icons.remove, color: Colors.grey[200],) : Icon(Icons.remove, color: Theme.of(context).primaryColor,),
                  onPressed: () {
                    setState(() {
                      quantity == 0 ? quantity = 0 : quantity-=1;
                    });
                  },
                ),
              ),
              SizedBox(//to give some space between buttons
                width: 10.0,
              ),
              Text(quantity.toString()),
              SizedBox(//to give some space between buttons
                width: 10.0,
              ),
              Container(//container containing the remove button
                height: 40.0,
                width: 30.0,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.add, color: Theme.of(context).primaryColor,),
                  onPressed: () {
                    setState(() {
                      quantity = quantity + 1;
                    });
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
