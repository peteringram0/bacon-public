import 'package:flutter/material.dart';
import './../../../utils/auth.dart';

class UserProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(snapshot.data.photoUrl),
              ),
            ),
          );
        } else {
          return const Text('');
        }
      },
    );
  }
}
