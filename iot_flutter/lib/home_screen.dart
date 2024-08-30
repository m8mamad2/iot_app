import 'package:flutter/material.dart';
import 'package:iot_flutter/service/mqtt_connection_service.dart';
import 'package:iot_flutter/utils/utils.dart';
import 'package:iot_flutter/widget/switch_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  MqttConnectionService mqttService = MqttConnectionService();

  @override
  void initState() {
    super.initState();

    mqttService.setup();
    mqttService.connection();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: isLamOnValue,
        builder: (context, value, child) => Container(
          color: value ? Color(0xff060912) : Colors.white,
          height: size(context).height,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                SwitchWidget(mqttService),
              ]
            ),
          ),
          ),
      )
    );
  }
}
