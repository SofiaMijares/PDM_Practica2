import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfindapp/bloc/findmusic_bloc.dart';

class FavoriteScreen extends StatelessWidget {
   
const FavoriteScreen({Key? key}) : super(key: key);
      
    @override
    
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('FavoriteScreen'),
            ),
            body: BlocBuilder<FindmusicBloc,FindmusicState>(
              builder: (context, state) {
                return state.favorites.isNotEmpty ? ListView(
                  children: state.favorites.map((e) => ListTile(
                    title: Text(e.title),
                    subtitle: Text(e.artist),
                    leading: Image.network(e.albumCover),
                   
                  )).toList(
                    growable: false,

                  )

                ) : const Center(child: Text('No hay favoritos'));
              }),
        );
    }
}