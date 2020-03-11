
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Arquivos {
  
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/Migrou.app');
  }

  Future<String> readContent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      // Returning the contents of the file
      return contents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }

  Future<File> writeContent(String tipoPessoa) async {
    final file = await _localFile;
    return file.writeAsString(tipoPessoa);
  }
  
}