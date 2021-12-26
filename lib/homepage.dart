import 'package:flutter/material.dart';
import 'package:vigenere_cipher/about.dart';
import 'package:vigenere_cipher/screen.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: ScreenWidth > 650
                  ? 600
                  : ScreenWidth > 900
                      ? 200
                      : 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'VIGENERE CIPHER APP',
                    style: TextStyle(fontSize: 35),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/logo.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 2,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      primary: false,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Screen(
                                title: 'VIGENERE CIPHER',
                              );
                            }));
                          },
                          child: Card(
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              child: Image.asset(
                                'assets/start.png',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const About();
                            }));
                          },
                          child: Card(
                            child: Image.asset('assets/about.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
