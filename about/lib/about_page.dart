import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const ROUTE_NAME = '/about';
  static const aboutText =
      'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: kPrussianBlue,
                  child: Center(
                    child: Image.asset(
                      'assets/circle-g.png',
                      width: 128,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  color: kMikadoYellow,
                  child: Text(
                    aboutText,
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              key: Key('back_button'),
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
