import 'package:flutter/material.dart';

class UserProfilePicture extends StatelessWidget {

  final height, width;
  UserProfilePicture(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new CircleAvatar(
            child: const Text('HS', style: TextStyle(fontSize: 20.0),),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromRGBO(48, 148, 163, 1)
        ),
        width: width,
        height: height,
        padding: const EdgeInsets.all(2.0), // border width
        decoration: new BoxDecoration(
          color: Color.fromRGBO(175, 172, 171, 1),// border color
          shape: BoxShape.circle,
        )
    );
  }
}
