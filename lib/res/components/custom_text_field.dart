import 'package:flutter/material.dart';
import 'package:nikkah_app/res/styles/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.validator,
    this.onChanged,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscured;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(31.r),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              suffixIcon: widget.obscureText
                  ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              )
                  : null,
              errorText: errorMessage,
              errorMaxLines: 2, // Allows wrapping for long error messages
            ),
            validator: (value) {
              String? validationResult = widget.validator?.call(value);
              setState(() {
                errorMessage = validationResult;
              });
              return validationResult;
            },
            onChanged: widget.onChanged,
            controller: widget.controller,
            obscureText: isObscured,
            keyboardType: widget.keyboardType,
            style: TextStyles.textField,
          ),
        ),
      ],
    );
  }
}
