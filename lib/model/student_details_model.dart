class StudentDetailsModel {
  String? name;
  String? standard;
  String? age;
  String? domain;

  StudentDetailsModel({
    this.name,
    this.standard,
    this.age,
    this.domain,
  });

  factory StudentDetailsModel.fromJson(Map<String, dynamic> json) {
    return StudentDetailsModel(
      name: json['name'],
      age: json['age'],
      domain: json["domain"],
      standard: json["standard"],
    );
  }
}
