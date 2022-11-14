import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class APIRepository {
  static final APIRepository _singleton = APIRepository._internal();

  factory APIRepository() {
    return _singleton;
  }

  APIRepository._internal();

  Future<dynamic> findSong(String path) async { 
    
    var request =  http.MultipartRequest('POST', Uri.parse('https://api.audd.io/'));
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      File(path).readAsBytesSync(),
      filename: 'music.m4a',
    ));
    request.fields['api_token'] = '93e9fc0f6dffe5c83f5b6275aa525ad3';
    request.fields['return'] = 'apple_music,spotify';
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    final res = jsonDecode(responseString);

    if (res['status'] == 'success') {
      if (res['result'] != null) {
        var musicInfo = res['result'];
        var title = musicInfo['title'];
        var artist = musicInfo['artist'];
        var releaseDate = musicInfo['release_date'];
        var apple = musicInfo['apple_music']['url'];
        var spotify = musicInfo['spotify']['album']['external_urls']['spotify'];
        var album = musicInfo['spotify']['album']['name'];
        var image = musicInfo['spotify']['album']['images'][1]['url'];
        var songLink = musicInfo['song_link'];
    return {
      'title': title,
      'artist': artist,
      'releasedate': releaseDate,
      'apple': apple,
      'spotify': spotify,
      'album': album,
      'image': image,
      'song_link': songLink,
    };
      } else {
        return "No se encontró la canción";
      }
    } else {
      return "No se pudo obtener la información";
    }
  }
}