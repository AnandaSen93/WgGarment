

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

const currency = "₹";

const pinkcolor = Color(0xFFED008C);
const lightgraykcolor = Color(0xFFF5F5F5);
const productbackgroundcolor = Color(0xFFE9E6E4);
const skybluecolor = Color(0xFF4EAEEF);









Color hexToColor(String hexString) {
  hexString = hexString.toUpperCase().replaceAll("#", ""); // Remove #
  
  if (hexString.length == 6) {
    hexString = "FF$hexString"; // Add full opacity if alpha is missing
  }

  return Color(int.parse(hexString, radix: 16));
}



String decodeAndCleanHtml(String htmlText) {
  // 1. Decode HTML entities
  var unescape = HtmlUnescape();
  String decoded = unescape.convert(htmlText);

  // 2. Remove HTML tags
  String cleaned = decoded.replaceAll(RegExp(r'<[^>]*>'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();

  return cleaned;
}



