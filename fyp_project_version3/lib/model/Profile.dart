import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String dataEmail;
  final String dataPassword;
  final String dataFirstName;
  final String dataLastName;
  final String dataNoIC;

  Profile(
    { this.dataEmail,
      this.dataPassword,
      this.dataFirstName,
      this.dataLastName,
      this.dataNoIC})

      : super([
        dataEmail,
        dataPassword,
        dataFirstName,
        dataLastName,
        dataNoIC
      ]);

      factory Profile.fromJson(Map<String, dynamic> json){
        return Profile(
          dataEmail: json['email'],
          dataPassword: json['password'],
          dataFirstName: json['fname'],
          dataLastName: json['lname'],
          dataNoIC: json['no_ic'], 
          );
      }

      Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.dataEmail;
        data['password'] = this.dataPassword;
        data['fname'] = this.dataFirstName;
        data['lname'] = this.dataLastName;
        data['no_ic'] = this.dataNoIC;
        return data;
      }
}