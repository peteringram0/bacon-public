import 'package:flutter/material.dart';
import './../../theme.dart';
import './../../utils/Auth.dart';
import './components/index.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _topArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 45.0, right: 45.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              UserProfile(),
              LogoutBtn(
                onPressed: () async {
                  await authService.signOut();
                  return true;
//                  Navigator.pushNamed(context, 'login');
                },
              )
            ],
          ),
          Row(
            children: <Widget>[Name()],
          )
        ],
      ),
    );
  }

  _bottomArea(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 45.0, right: 45.0, bottom: 22),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Sets', style: AppTheme.smallText),
                ],
              ),
            ],
          ),
        ),
        Sets()
      ],
    );
  }

  _langSelection(BuildContext context) {
    return DropdownButton<String>(
      value: 'Vietnamese',
      icon: Icon(Icons.arrow_downward),
      onChanged: (String newValue) {
        authService.updateLearningData(newValue);
        Navigator.of(context).pop();
      },
      items: <String>['Vietnamese'].map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }

  _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            child: Text(
              "Which Language Are You Studying",
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.center,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_langSelection(context)],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    /// If we don't have a learning lang, request one.
    authService.getUser().then((value) {
      if (value.learning == null) {
        _showDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorGreen,
      body: Column(
        children: <Widget>[
          Expanded(
            child: _topArea(context),
          ),
          Expanded(
            child: _bottomArea(context),
          ),
        ],
      ),
    );
  }
}
