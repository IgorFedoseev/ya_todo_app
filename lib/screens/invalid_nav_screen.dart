import 'package:flutter/material.dart';

class InvalidNavigationScreenWidget extends StatelessWidget {
  const InvalidNavigationScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bad way'),
      ),
      body: const Center(
        child:
            Text('Что-то пошло не так\nПожалуйста, перезагрузите приложение'),
      ),
    );
  }
}
