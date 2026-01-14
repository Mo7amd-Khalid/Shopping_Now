import 'package:flutter/material.dart';
import 'package:E_Commerce/core/utils/context_func.dart';

class OTPInput extends StatelessWidget {
  const OTPInput({required this.controller,this.autoFocus = false, super.key});

  final TextEditingController controller;
  final bool autoFocus;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.widthSize / 7,
      height: context.heightSize * 0.07,
      child: TextFormField(
        controller: controller,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value){
          if(value.isNotEmpty)
            {
              FocusScope.of(context).nextFocus();
            }

        },
      ),
    );
  }
}
