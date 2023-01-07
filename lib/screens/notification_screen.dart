import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../providers/providers.dart';

class NotificationScreen extends StatefulWidget {
   
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // String url ='https://firebasestorage.googleapis.com/v0/b/chifabrasil-app.appspot.com/o/Ringtone%2FJoji%20-%20Glimpse%20Of%20Us.mp3?alt=media&token=86ed10f2-1951-427a-ac38-8a3c21bfe311';
  //  String url ='GlimpseOfUs.mp3';
  AudioPlayer advancedPlayer= AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    advancedPlayer=AudioPlayer();
    // advancedPlayer.play(url, isLocal: true);
    AudioCache audioCache= AudioCache(fixedPlayer: advancedPlayer );

    audioCache.play('ringtone.mp3');
  }

  @override
  Widget build(BuildContext context) {
    
    final uiProvider = Provider.of<UiProvider>(context);
    final String args= ModalRoute.of(context)?.settings.arguments as String;
    return  Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(width: double.infinity,),  
        Text(args, style: TextStyle(fontSize: 25),),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(onPressed: (){
            advancedPlayer.stop();
            uiProvider.selectedMenuOpt=0;
            Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.pushReplacementNamed(
                                    context, 'navigationScreen');
          }, child: Text('Ir a inicio')),
        )

      ],),
    );
  }
}