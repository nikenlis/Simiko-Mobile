import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';

class FormItems extends StatefulWidget {
  final String title;
  final bool obsecureText;
  final TextEditingController? controller;
  final bool isShowTitle;
  final bool iconVisibility;
  final Function(String)? onFieldSubmitted;
  final bool isShowHint;
  final String? hintTitle;
  final String? errorText;
  //final bool isError;
  final bool readOnly;
  final List<TextInputFormatter> textInputFormatter;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;


  const FormItems({
    super.key,
    required this.title,
    this.obsecureText = false,
    this.controller,
    this.isShowTitle = true,
    this.iconVisibility = false,
    this.onFieldSubmitted,
    //this.isError = false,
    this.errorText,
    this.readOnly = false, 
    this.isShowHint = false, 
    this.hintTitle, 
    required this.textInputFormatter, 
    required this.textInputAction, 
    required this.textInputType, 
    this.focusNode, 
    this.onChanged, this.validator,
  });

  @override
  State<FormItems> createState() => _FormItemsState();
}

class _FormItemsState extends State<FormItems> {
  late bool _obsecureText;

  @override
  void initState() {
    super.initState();
    _obsecureText = widget.obsecureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowTitle)
          Text(
            widget.title,
            style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
        if (widget.isShowTitle)
          const SizedBox(
            height: 8,
          ),
        TextFormField(
          obscureText: _obsecureText,
          controller: widget.controller,
          readOnly: widget.readOnly,
          inputFormatters: widget.textInputFormatter,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          style: TextStyle(
            color: blackColor,
            fontSize: 16,
            fontWeight: regular,
          ),
          decoration: InputDecoration(
              hintText: widget.isShowHint ? widget.hintTitle : null,
              hintStyle:
                  greyTextStyle.copyWith(fontSize: 16, fontWeight: regular),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: greyColor, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: purpleColor, width: 1.0),
              ),
              errorText: widget.errorText,
              errorStyle: redTextStyle.copyWith(fontSize: 16, fontWeight: regular),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: redColor, width: 1),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              isDense: true,
              filled: true,
              fillColor: whiteColor,
              suffixIcon: widget.iconVisibility
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecureText = !_obsecureText;
                        });
                      },
                      icon: Icon(
                        _obsecureText ? Icons.visibility_off : Icons.visibility,
                        color: greyColor,
                        size: 24,
                      ))
                  : null),
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
      ],
    );
  }
}
