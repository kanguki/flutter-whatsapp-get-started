import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static String restEnpoint = dotenv.get('REST_ENPOINT');
  static String getStudentsInfo = "$restEnpoint/students/info"; //?name=xx&offset=0&limit=1
  static String getStudentNames = "$restEnpoint/students";
  static int getStudentLimit = 10;
}