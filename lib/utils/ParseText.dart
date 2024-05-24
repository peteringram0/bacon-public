import './../utils/Auth.dart';

class ParseText {
  static String parse(String text) {
    var _openIndex = text.indexOf('{');

    if (_openIndex != -1) {
      var _closeIndex = text.indexOf('}') + 1;
      return text.substring(0, _openIndex) + authService.localUser.displayName + text.substring(_closeIndex);
    } else {
      return text;
    }
  }
}
