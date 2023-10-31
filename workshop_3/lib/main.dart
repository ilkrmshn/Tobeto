import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 214, 16, 16),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/image.jpg'),
                width: 200,
                height: 300,
              ),
              Text(
                "İlker Muhsin Şahin",
                style: TextStyle(
                    fontSize: 35, color: Colors.white, letterSpacing: 2),
              ),
              Text(
                "Tobeto - Mobil Geliştirici 1A",
                style: TextStyle(
                    fontSize: 20, color: Colors.white, letterSpacing: 2),
              ),
              Text(
                "31,10,2023",
                style: TextStyle(
                    fontSize: 20, color: Colors.black, letterSpacing: 2),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
