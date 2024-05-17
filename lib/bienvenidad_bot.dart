import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
 // Importa la pantalla de destino

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MyScreen(name: "TuNombre"), // Aquí puedes pasar el nombre desde el backend
      ),
    );
  }
}

class MyScreen extends StatelessWidget {
  final String name;

  const MyScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Top right circle
        Positioned(
          top: -57,
          left: 300,
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Color(0xFF4157FF),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Bottom left circle
        Positioned(
          top: 581,
          left: -61,
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Color(0xFF4157FF),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Image container
        Positioned(
          top: 130,
          left: 135,
          child: Container(
            width: 130,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage('assets/images/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Center text
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Hola, $name!',
                style: const TextStyle(
                  color: Color(0xFF4157FF),
                  fontSize: 32,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.0, // La propiedad height se establece como un factor multiplicador de fontSize
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Me llamo Coni y seré tu asistente virtual.\nPrimero Conozcámonos!',
                style: TextStyle(
                  color: Color(0xFF4157FF),
                  fontSize: 16,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  height: 1.8125, // height adjusted for 16px font size
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FormularioApp()),
                  );
                },
                style: ButtonStyle(
                  // ignore: deprecated_member_use
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4157FF)),
                  // ignore: deprecated_member_use
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  // ignore: deprecated_member_use
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(239, 56),
                  ),
                ),
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w700,
                    height: 1.3, // height adjusted for 20px font size
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}