import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String dataId;
  final String dataEmail;
  final String dataPassword;

  Student({this.dataId, this.dataEmail, this.dataPassword})
      : super([dataId, dataEmail, dataPassword]);

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      dataId: json['userid'],
      dataEmail: json['email'],
      dataPassword: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.dataId;
    data['email'] = this.dataEmail;
    data['password'] = this.dataPassword;
    return data;
  }
}
