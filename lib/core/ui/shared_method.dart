import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:html/parser.dart' as html_parser;

import '../theme/app_colors.dart';

void showCustomSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    borderRadius: BorderRadius.circular(16),
    duration: const Duration(seconds: 2),
  ).show(context);
}

Future<File> getImage () async { 
final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery); 
File  file  = File(image!.path); 
return file; 
}

String formatTimeAgo(DateTime dateTime) {
  return timeago.format(dateTime, locale: 'en');
}

String parseHtmlToPlainText(String htmlString) {
  final document = html_parser.parse(htmlString);
  return document.body?.text.trim() ?? '';
}

String formatTanggal(DateTime dateTime) {
  final formatter = DateFormat("dd MMMM yyyy", "id_ID");
  return formatter.format(dateTime);
}

String formatTanggalFromString(String dateString) {
  try {
    final dateTime = DateTime.parse(dateString);
    final formatter = DateFormat("dd MMMM yyyy", "id_ID");
    return formatter.format(dateTime);
  } catch (e) {
    return "-";
  }
}