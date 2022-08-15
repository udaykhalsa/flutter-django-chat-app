import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'user_auth.dart';

class CarousalSlides extends StatelessWidget {
  final String imageLink;
  final String carouselText;
  const CarousalSlides(
      {Key? key, required this.imageLink, required this.carouselText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage(imageLink),
            height: 375.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            carouselText,
            style: TextStyle(fontSize: 28.0, color: Colors.grey.shade900),
          ),
        )
      ],
    );
  }
}

class AppIntroHome extends StatefulWidget {
  const AppIntroHome({Key? key}) : super(key: key);

  @override
  State<AppIntroHome> createState() => _AppIntroHomeState();
}

class _AppIntroHomeState extends State<AppIntroHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.amberAccent.shade100,
              Colors.amberAccent,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const RegisterPage(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade900,
                      primary: Colors.white,
                      fixedSize: const Size(175.0, 50.0)),
                  child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade900,
                      primary: Colors.white,
                      fixedSize: const Size(175.0, 50.0)),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
