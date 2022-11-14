import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfindapp/bloc/findmusic_bloc.dart';

import 'package:avatar_glow/avatar_glow.dart';


class HomeScreen extends StatelessWidget {
   const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Create a column with 3 children

      body:BlocBuilder<FindmusicBloc,FindmusicState>(
        builder: (context, state) {
          return Column(
          children: [
            
            const SizedBox(height: 150,),
            //Center the text
            Center(child: Text( state.isRecording ? 'Escuchando...' : 'Toque para escuchar',style: Theme.of(context).textTheme.headline4,)),
            const SizedBox(height: 100),
            //Create a circled button
             AvatarGlow(
                glowColor: Colors.red,
                endRadius: 150.0,
                animate: state.isRecording,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: Material(     // Replace this child with your own
                  // elevation: 10.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 100.0,
                    child: IconButton(
                      color: Colors.red,
                      icon: state.isRecording ? const Icon(Icons.stop) : const Icon(Icons.mic),
                      iconSize: 100,
                      onPressed: () {
                        //Start recording
                        // Navigator.pushNamed(context, 'details', arguments: '1');
                        BlocProvider.of<FindmusicBloc>(context).add(IsRecording(isRecording: !state.isRecording));
                        // record.start();
                      },
                    ),
                    
                  ),
                ),
              ),
      
              const SizedBox(height: 100,),
      
              CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 35.0,
                child: IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.favorite),
                  iconSize: 40,
                  onPressed: () {
                    //navigate to favorites screen
                    Navigator.pushNamed(context, 'favorites');
                  },
                ),
              )
      
            
          ],
        );
        },
        
      ) 
    );
        
  }
}
