import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:musicfindapp/API/music_api.dart';
import 'package:record/record.dart';


part 'findmusic_event.dart';
part 'findmusic_state.dart';
final record = Record();
final api = APIRepository();

class FindmusicBloc extends Bloc<FindmusicEvent, FindmusicState> {
  FindmusicBloc() : super(FindmusicInitial()) {
    on<IsRecording>((event, emit) async{
      emit(FindmusicRecording(event.isRecording));
      // Check and request permission
      if(event.isRecording){

        if (await record.hasPermission()) {
          // Start recording
          await record.start(
            encoder: AudioEncoder.aacLc, // by default
            bitRate: 128000, // by default
            samplingRate: 44100, // by default
          );
        }
      }else{

        // Stop recording
        final filename = await record.stop();
        final res = await api.findSong(filename!);
        print(res);
        
      }
    });
    //Local Favorites
    // on<AddFavorite>((event, emit) {
    //   final found = state.favorites.firstWhere((element) => element['title'] == event.title && element['artist'] == event.artist, orElse: () => null);
    //   if(found){
    //    return emit(FindMusicFavoritesError(errorMessage: 'La canción ya está en favoritos'));
    //   }
    //   final newFavorites = [...state.favorites, {'title': event.title, 'artist': event.artist}];
    // emit(FindMusicFavorites(newFavorites));
    // });

    //Firebase Favorites
    // on<AddFavorite>((event, emit) async {
    //   final found = await _getFavorites()!!.firstWhere((element) => element['title'] == event.title && element['artist'] == event.artist, orElse: () => null);
    //   if(found != null){
    //    return emit(FindMusicFavoritesError(errorMessage: 'La canción ya está en favoritos'));
    //   }
    //   _addFavorite(event.title, event.artist);
    // });
    on<GetFavorites>(((event, emit) async{
      final favorites = await _getFavorites();
      emit(ListFavorites(favorites: favorites));
    }));

    on<RemoveFavorite>((event, emit) async{
      await _removeFavorite(event.title, event.artist);
    });
  }
  
}

FutureOr _getFavorites() async {
  //Get favorites from firebase
  final collection = FirebaseFirestore.instance.collection('favorites');
  final favorites = await collection.get();
  return favorites.docs.map((e) => e.data()).toList();
}

FutureOr _addFavorite(String title, String artist) async {
  //Add favorites to firebase
  final collection = FirebaseFirestore.instance.collection('favorites');
  await collection.add({'title': title, 'artist': artist});
}

FutureOr _removeFavorite(String title, String artist) async {
  //Remove favorites from firebase
  final collection = FirebaseFirestore.instance.collection('favorites');
  final favorites = await collection.get();
  final favorite = favorites.docs.firstWhere((element) => element.data()['title'] == title && element.data()['artist'] == artist);
  await collection.doc(favorite.id).delete();
}