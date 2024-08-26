
import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttConnectionService{

  final client = MqttServerClient('192.168.178.143', '');
  int ping = 0;
  int pong = 0;

  Future setup()async{
    client.port = 1883;
    client.logging(on: true);
    client.setProtocolV311();
    client.keepAlivePeriod = 60;
    client.connectTimeoutPeriod = 5;
    client.connectTimeoutPeriod = 2000;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
  }

  onDisconnected()=> print('onDisconnected ->>>>>>>>>>>>>>>>>>');
  onConnected()=> print('onConnected ->>>>>>>>>>>>>>>>>>');
  onSubscribed(String topic)=> print('onSubscribed: $topic ->>>>>>>>>>>>>>>>>>');
  onSubscribeFail(String error)=> print('onSubscribeFail: $error ->>>>>>>>>>>>>>>>>>');

  Future connection()async{

    final connectMqtt = MqttConnectMessage()
      .withClientIdentifier('my')
      .withWillTopic('willtopic')
      .withWillMessage('my will message')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connectMqtt;
    
    try{
      await client.connect();
      print('--------> Mosauitto client connection');
    }
    on NoConnectionException catch(e){
      print(' 1 -----------> $e');
      client.disconnect();
    }
    on SocketException catch(e){
      client.disconnect();
      print('2---------> $e');
    }
    catch(e){
      client.disconnect();
      print('3---------> $e');
    }

    if(client.connectionStatus!.state == MqttConnectionState.connected)print('Mosquitto Client is Connected   --- +++ :)');
    else {
      print('MOsquitto not connected --- :(  and State is ---> ${client.connectionStatus}');
      client.disconnect();
    }


  }

  subscription(String topic)async{
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? data) {
      final recMess = data![0].payload as MqttPublishMessage;
      final parseData = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      // print('EXAMPLE::Change notification:: topic is <${data[0].topic}>, payload is <-- $pt -->');

      print('Topic is --> ${data[0].topic}');
      print('Data is --> $parseData ');
    });
    client.published!.listen((MqttPublishMessage message) {
      print('EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });
  }
  
  publish(String topic,String pyload)async{
    final builder = MqttClientPayloadBuilder();
    builder.addString(pyload);
    client.subscribe(topic,  MqttQos.exactlyOnce);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    await MqttUtilities.asyncSleep(60);
  }


}
