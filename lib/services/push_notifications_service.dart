//SHA-1: EE:97:71:67:1A:24:43:C9:9D:05:82:4B:29:CC:2F:21:41:FB:6F:47

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService{
  static FirebaseMessaging messaging= FirebaseMessaging.instance;
  static String? token;

  static Future _backgroundHandler( RemoteMessage message) async{
    print(' background Handler ${message.messageId}');
  }
   static Future _onMessageHandler( RemoteMessage message) async{
    print(' background Handler ${message.messageId}');
  }
   static Future _onMessageOpenApp( RemoteMessage message) async{
    print(' background Handler ${message.messageId}');
  }

  static Future initializeApp()async{

    await Firebase.initializeApp();

    token=await FirebaseMessaging.instance.getToken();
    print('token: $token');

    FirebaseMessaging.onBackgroundMessage( _backgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );

  }
}