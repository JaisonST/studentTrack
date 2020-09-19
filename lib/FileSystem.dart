

import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileSystem {
  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  Future<String> getPath() async {
    return await _localPath;
  }

  Future<File> get _localFile async {
     final path = await _localPath;
     return File('$path/Records.csv');
  }

  Future<File> writeFile(String str) async{
    final file = await _localFile;
    return file.writeAsString(str);
  }


}