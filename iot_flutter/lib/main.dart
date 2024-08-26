import 'package:flutter/material.dart';
import 'package:iot_flutter/home_screen.dart';
import 'package:iot_flutter/service/mqtt_connection_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}


class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  MqttConnectionService mqttService = MqttConnectionService();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: ()async{
              mqttService.setup();
              await mqttService.connection();
            }, 
            child: Text('Connected')),

          ElevatedButton(
            onPressed: ()async=> mqttService.subscription("test/topic"), 
            child: Text('Suscribe')),

          ElevatedButton(
            onPressed: ()async=> mqttService.publish("test/topic", "on"),
            child: Text('Publish')),

        ],)
    );
  }
}