//SHA-1: EE:97:71:67:1A:24:43:C9:9D:05:82:4B:29:CC:2F:21:41:FB:6F:47

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService{
  static FirebaseMessaging messaging= FirebaseMessaging.instance;
  static String? token;
  static  StreamController<String>_messageStream= StreamController.broadcast();
  static Stream<String> get messageStream=>_messageStream.stream;

  static Future _backgroundHandler( RemoteMessage message) async{
   _messageStream.add( message.notification?.title?? 'notificación' );
   print(' background Handler ${message.messageId}');
  }
   static Future _onMessageHandler( RemoteMessage message) async{
    _messageStream.add( message.notification?.title?? 'notificación' );
    print(' onMessage Handler ${message.messageId}');

  }
   static Future _onMessageOpenApp( RemoteMessage message) async{
    _messageStream.add( message.notification?.title?? 'notificación' );
    print(' onMessageOpen Handler ${message.messageId}');
  }

  static Future initializeApp()async{

    await Firebase.initializeApp();

    token=await FirebaseMessaging.instance.getToken();
    print('token: $token');

    FirebaseMessaging.onBackgroundMessage( _backgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );

  }

  static closeStreams()
{
  _messageStream.close();
}}