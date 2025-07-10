import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Slugview extends StatefulWidget {
  const Slugview({super.key});

  @override
  State<Slugview> createState() => _SlugviewState();
}

class _SlugviewState extends State<Slugview> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: Column(
          children: [
               // Header
          Container(
            color: Colors.transparent,
            height: 60,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new)),
                SizedBox(width: 80),
                Image.asset(
                  'assets/images/app_logo.png',
                  fit: BoxFit.contain,
                ),
                Spacer()
              ],
            ),
          ),
          ],

        )
      ),
    );
  }
}