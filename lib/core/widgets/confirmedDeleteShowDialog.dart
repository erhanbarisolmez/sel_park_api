import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final dynamic dialogHeaderBlackText;
  final dynamic dialogHeaderColorText;
  final dynamic dialogBodyBlackText;
  final dynamic dialogBodyColorText;
  final dynamic buttonOK;
  final dynamic buttonCancel;
  final IconData icon;

  const ConfirmDeleteDialog({
    super.key,
    required this.onPressed,
    this.dialogHeaderBlackText,
    this.dialogHeaderColorText,
    this.dialogBodyBlackText,
    this.dialogBodyColorText,
    this.buttonOK,
    this.buttonCancel,
    this.icon = Icons.delete_forever_sharp,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Stack(
        children: <Widget>[
          Text(
            // park.parkName ?? 'Delete',
            dialogHeaderBlackText,
            style: _dialogHeaderBlackTextStyle(),
          ),
          Text(
            // park.parkName ?? 'Delete',
            dialogHeaderColorText,
            style: _dialogHeaderColorTextStyle(),
          ),
        ],
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Icon(icon, size: 50, color: Colors.yellow.shade100),
                  const SizedBox(width: 30.0),
                  Stack(
                    children: <Widget>[
                      Text(
                        // 'Do you want to delete?',
                        dialogBodyBlackText,
                        style: _dialogBodyBlackTextStyle(),
                      ),
                      Text(
                        // 'Do you want to delete?',
                        dialogBodyColorText,
                        style: _dialogBodyColorTextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: _butttonStyleOK(),
              onPressed: onPressed, // Call the provided onPressed callback
              child: Text(
                // 'YES',
                buttonOK,
                style: _textButtonStyleOK(),
              ),
            ),
            TextButton(
              style: _buttonStyleCancel(),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                // 'Cancel',
                buttonCancel,
                style: _textButtonStyleCancel(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  TextStyle _textButtonStyleCancel() {
    return GoogleFonts.rajdhani(
        color: Colors.orange.shade100,
        fontSize: 18,
        fontWeight: FontWeight.bold);
  }

  ButtonStyle _buttonStyleCancel() {
    return TextButton.styleFrom(
        backgroundColor: Colors.transparent, minimumSize: const Size(200, 50));
  }

  TextStyle _textButtonStyleOK() {
    return GoogleFonts.rajdhani(
        color: const Color(0xffffffff),
        fontSize: 18,
        fontWeight: FontWeight.bold);
  }

  ButtonStyle _butttonStyleOK() {
    return TextButton.styleFrom(
        backgroundColor: Colors.black38, minimumSize: const Size(200, 50));
  }

  TextStyle _dialogHeaderColorTextStyle() {
    return TextStyle(
      fontSize: 30,
      color: Colors.grey[300],
      letterSpacing: 2,
      fontWeight: FontWeight.w800,
    );
  }

  TextStyle _dialogHeaderBlackTextStyle() {
    return TextStyle(
      fontSize: 30,
      letterSpacing: 2,
      fontWeight: FontWeight.w800,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = Colors.black45!,
    );
  }

  TextStyle _dialogBodyColorTextStyle() {
    return TextStyle(
      fontSize: 20,
      color: Colors.grey[300],
      letterSpacing: 2,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle _dialogBodyBlackTextStyle() {
    return TextStyle(
        fontSize: 20,
        letterSpacing: 2,
        fontWeight: FontWeight.w700,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.black!);
  }
}
