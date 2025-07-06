import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TextHtml extends StatelessWidget {
  final String data;
  final double fontSizeP;
  final double fontSizeH1;
  final double fontSizeH2;
  final FontWeight fontWeightP;
  final FontWeight fontWeightH1;
  final FontWeight fontWeightH2;

  const TextHtml({
    super.key,
    required this.data,
    this.fontSizeP = 16,
    this.fontSizeH1 = 24,
    this.fontSizeH2 = 20,
    this.fontWeightP = FontWeight.normal,
    this.fontWeightH1 = FontWeight.bold,
    this.fontWeightH2 = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        "*": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "html": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "body": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "div": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "h1": Style(
          padding: HtmlPaddings.zero,
          fontSize: FontSize(fontSizeH1),
          fontWeight: fontWeightH1,
          margin: Margins.only(bottom: 16),
          color: Colors.black87,
        ),
        "h2": Style(
          padding: HtmlPaddings.zero,
          fontSize: FontSize(fontSizeH2),
          fontWeight: fontWeightH2,
          margin: Margins.only(bottom: 12),
        ),
        "p": Style(
          padding: HtmlPaddings.zero,
          fontSize: FontSize(fontSizeP),
          fontWeight: fontWeightP,
          lineHeight: LineHeight(1.5),
          margin: Margins.only(bottom: 12),
          color: Colors.black87,
        ),
        "b": Style(fontWeight: FontWeight.bold),
        "i": Style(fontStyle: FontStyle.italic),
        "u": Style(textDecoration: TextDecoration.underline),
        "br": Style(
          display: Display.block,
          margin: Margins.symmetric(vertical: 8),
        ),
        "ul": Style(
          padding: HtmlPaddings.only(left: 20),
          margin: Margins.only(bottom: 12),
        ),
        "li": Style(
          fontSize: FontSize(fontSizeP),
          lineHeight: LineHeight(1.5),
        ),
        "a": Style(
          color: Colors.blue,
          textDecoration: TextDecoration.underline,
        ),
        "strong": Style(fontWeight: FontWeight.bold),
        "em": Style(fontStyle: FontStyle.italic),
      },
    );
  }
}
