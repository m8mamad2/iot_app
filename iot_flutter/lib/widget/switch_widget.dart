
import 'package:flutter/material.dart';
import 'package:iot_flutter/service/mqtt_connection_service.dart';
import 'package:iot_flutter/utils/utils.dart';

class SwitchWidget extends StatefulWidget {
  final MqttConnectionService mqttService;
  SwitchWidget(this.mqttService);
  
  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}
class _SwitchWidgetState extends State<SwitchWidget> {

  Alignment SwitchWidgetAlignment = Alignment.centerLeft;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: InkWell(
        onTap: () {
      
          if(value){
            widget.mqttService.publish("device/led", "0");
            isLamOnValue.value = false;
          }
          
          else{
            widget.mqttService.publish("device/led", "1");
            isLamOnValue.value = true;
          }
            
          setState(() { value = !value; });
      
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.decelerate,
          width: size(context).width *0.7,
          height: size(context).height*0.13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: value ? Color(0xFF4F77F1) : Color(0xFFDCDCDC),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            curve: Curves.decelerate,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: value ? Color(0xff060912) : Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: RotatedBox(
                  quarterTurns:3,
                  child: Icon(value ? Icons.dark_mode : Icons.light_mode , color: value ? Colors.white : Colors.black,size: 30)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

