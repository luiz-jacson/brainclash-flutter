import 'package:flutter/material.dart';

class AppIcons {
  static const String googleIconPath = 'assets/images/google_icon.png';
  static const IconData science = Icons.science;
  static const IconData history = Icons.book;
  static const IconData math = Icons.calculate;
  static const IconData geography = Icons.public;
  static const IconData art = Icons.palette;
  static const IconData music = Icons.music_note;
  static const IconData sports = Icons.emoji_events;
  static const IconData generalKnowledge = Icons.psychology;

  static IconData parseIcon(dynamic codePoint) {
    if (codePoint == null || codePoint == "") {
      return Icons.help_outline;
    }

    return IconData(codePoint, fontFamily: 'MaterialIcons');
  }
}
