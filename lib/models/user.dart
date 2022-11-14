import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String photo;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
  });
  static const empty = User(
    id: '',
    name: '',
    email: '',
    photo: '',
  );
  @override
  List<Object> get props => [id, name, email, photo];
}
