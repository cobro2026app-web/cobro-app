import 'dart:async';

String _message = "";
String _code = "";
bool _sendcode = false;

set setMesage(String? message) {
  _message = message!;
}

set setCode(String? code) {
  _code = code!;
}

String _codeError = "";

get getMessage => _message;
get getCode => _code;
get getCodeError => _codeError;
get sentCode => _sendcode;
StreamController<bool> codeSent = StreamController.broadcast();
Stream<bool> get getcodeSent => codeSent.stream;