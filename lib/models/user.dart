import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  User({this.id, this.name, this.avatarImageUrl, this.follower, this.email});
  final String? name;
  final String? email;
  final int? follower;
  final String? avatarImageUrl;
  final String? id;

  factory User.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return User(id: '', name: '', avatarImageUrl: '');
    final name = json['display_name'];
    final avatarImageUrl =
        json['images'].length != 0 ? json['images'][0]['url'] : null;
    final id = json['id'];
    final email = json['email'];
    final follower = json['followers']['total'];
    return User(
        name: name,
        avatarImageUrl: avatarImageUrl,
        id: id,
        email: email,
        follower: follower);
  }

  factory User.empty() {
    return User();
  }

  Map<String, dynamic> toJson() => {
        'display_name': name,
        'email': email,
        'images': [
          {'url': avatarImageUrl}
        ],
        'id': id
      };

  @override
  List<Object> get props => [name!, avatarImageUrl!, id!];
}
