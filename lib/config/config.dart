import 'dart:convert';

import 'package:flutter/services.dart';

class Configuration {
  static Future<Map<String, dynamic>> getConfig() {
    return rootBundle.loadString('assets/config/config.json').then(
          //jsondecode convert string to Object
          (value) => jsonDecode(value) as Map<String, dynamic>,
        );
  }
}
