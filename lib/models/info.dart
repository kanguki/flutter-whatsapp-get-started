class Info {
  Info({this.name, this.school, this.age, this.address});
  String? name;
  String? school;
  int? age;
  String? address;

  static List<Info>? fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      json[key] = json[key] as List;
      for (var e in json[key]) {
        e = e as Map;
      }
    });
    if (json['Student'] == null) {
      return null;
    }
    Map<String?, Info> infoMap = {
      for (var student in json['Student']!
          .map((obj) => Info(name: obj['name'], school: obj['school']))
          .toList())
        student.name: student
    };
    List<Map>? personalInfoList = json['PersonalInfo'];
    if (personalInfoList == null) {
      return infoMap.values.toList();
    }
    for (var i = 0; i < personalInfoList.length; i++) {
      String? name = personalInfoList[i]['name'];
      if (name == null || infoMap[name] == null) {
        continue;
      }
      infoMap[name]!.address = personalInfoList[i]['address'];
      infoMap[name]!.age = personalInfoList[i]['age'];
    }
    return infoMap.values.toList();
  }
}
