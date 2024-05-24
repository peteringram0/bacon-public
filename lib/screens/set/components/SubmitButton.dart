import 'package:Bacon/theme.dart';
import 'package:flutter/material.dart';
//import './../../../services/Api.dart';

class SubmitButton extends StatefulWidget {

  final String setId;

  SubmitButton({Key key, @required this.setId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SubmitButtonState();
}

class SubmitButtonState extends State<SubmitButton> {
  bool _disabled = true;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _disabled,
      child: FlatButton(
        color: _disabled
            ? AppTheme.colorBlue.withOpacity(.4)
            : AppTheme.colorBlue.withOpacity(.9),
        // Colors.transparent
        splashColor: AppTheme.colorBlue,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              const Text(
                "Submit Set",
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        onPressed: _disabled ? () {} : _submit,
        shape: const StadiumBorder(),
      ),
    );
  }

  void _submit() {
//    api.createReviewSet(widget.setId);
  }

  void setDisabled(bool disabled) {
    setState(() {
      _disabled = disabled;
    });
  }
}
