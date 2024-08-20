import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 251, 212,1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const SizedBox(height: 100),
            Image.asset(
              'assets/logo.jpg', 
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'WEATHER WISE',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                     padding: const EdgeInsets.only(left: 60, right: 60),
                   backgroundColor: const Color.fromARGB(255, 26, 80, 216), // warna tombol
                    textStyle: const TextStyle(fontSize: 16), shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), 
                    ),
                  ),
                  child: const Text('Discover the weather',style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
