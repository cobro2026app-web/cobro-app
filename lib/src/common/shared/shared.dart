import 'package:personal/src/domain/entities/config_entity.dart' show DataConEntity;

class Shared {
  
 static  DataConEntity? _config;
  static set setConfig(DataConEntity c){
    _config = c;
  }

  static  DataConEntity? get getConfig => _config;
}