part of 'findmusic_bloc.dart';

@immutable
abstract class FindmusicEvent {}

class IsRecording extends FindmusicEvent {
  final bool isRecording;
  IsRecording({required this.isRecording});
}

class GetFavorites extends FindmusicEvent {}

class RemoveFavorite extends FindmusicEvent {
  final String title;
  final String artist;
  RemoveFavorite({required this.title, required this.artist});
}
class AddFavorite extends FindmusicEvent {
  final String title;
  final String artist;
  AddFavorite({required this.title, required this.artist});
}