part of 'findmusic_bloc.dart';

@immutable
abstract class FindmusicState {
  final Record record = Record(); 
  final bool isRecording ;
  final List favorites ;
  final String message;
  FindmusicState({this.isRecording = false, this.favorites = const [],this.message = ''});
}

class FindmusicInitial extends FindmusicState {
  FindmusicInitial() : super(isRecording: false, favorites:const  []);
}

class FindmusicRecording extends FindmusicState {
  final bool recording;
  FindmusicRecording(this.recording) : super(isRecording: recording, favorites:const  []);
}

class FindmusicStop extends FindmusicState {
  FindmusicStop() : super(isRecording: false, favorites:const  []);
}

class FindmusicError extends FindmusicState {
  FindmusicError() : super(isRecording: false, favorites:const  []);
}

class FindmusicFavorites extends FindmusicState {
  FindmusicFavorites({required List favorites}) : super(isRecording: false, favorites: favorites);
}
class ListFavorites extends FindmusicState {
  ListFavorites({required List favorites}) : super(isRecording: false, favorites: favorites);
}

class FindMusicFavoritesError extends FindmusicState {
  final String errorMessage = '';
  FindMusicFavoritesError({required String errorMessage}) : super(message: errorMessage);
}

class FindmusicFavoritesAdd extends FindmusicState {
  final Object newFavorite = {};
  FindmusicFavoritesAdd({required Object newFavorite}) ;
}