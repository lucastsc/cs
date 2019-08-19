import 'package:college_snacks/datas/card_colors.dart';
import 'package:flutter/material.dart';
import 'package:college_snacks/blocs/card_manage_bloc.dart';
import 'package:college_snacks/blocs/bloc_provider.dart';

class CardBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final CardManageBloc bloc = BlocProvider.of<CardManageBloc>(context);

    return StreamBuilder<int>(
      stream: bloc.cardColorIndexSelected,
      initialData: 6,
      builder: (context, snapshot){
        return Container(
          decoration: BoxDecoration(
            color: snapshot.hasData ? CardColor.baseColors[snapshot.data] :
                CardColor.baseColors[0],
            borderRadius: BorderRadius.circular(15.0)
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50.0,),
                Row(
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage('assets/card_band.jpg'),
                        width: 200.0,
                      ),
                    ),
                    SizedBox(width: 15.0,),
                    Container(
                      width: 65.0,
                      height: 42.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Colors.red, width: 3.0),
                        color: Colors.white
                      ),
                      child: Center(
                        child: StreamBuilder<String>(
                          stream: bloc.cardCvv,
                          builder: (context, snapshot){
                            return Text(
                              snapshot.hasData ? snapshot.data : '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 12.0),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(10.0),
                    child: Image(
                      image: AssetImage('assets/card_back.jpg'),
                      width: 65.0,
                      height: 40.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
