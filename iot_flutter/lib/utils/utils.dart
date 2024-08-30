import 'package:flutter/material.dart';

const kDarkBackgroundColor = Color(0xff000);
const kWhiteBackgroundColor = Color(0xff000);


Size size(BuildContext context)=> MediaQuery.sizeOf(context);

ValueNotifier<bool> isLamOnValue = ValueNotifier<bool>(false);