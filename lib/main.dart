import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_app/click_meal/click_meal_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: MealApp(),
    );
  }
}

class MealApp extends StatefulWidget {
  const MealApp({super.key});

  @override
  State<MealApp> createState() => _MealAppState();
}

class _MealAppState extends State<MealApp> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Get.to(() => const ClickMealView()),
                child: Container(
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Share your meal',
                      style: GoogleFonts.elsie(fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
