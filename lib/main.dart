import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/form_trabajo.dart';

void main() {
  runApp(const FormularioApp());
}

class FormularioApp extends StatelessWidget {
  const FormularioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Datos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'SourceSansPro'),
        ),
      ),
      home: const FormularioPage(),
    );
  }
}

class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();
  String _genero = 'Masculino';
  String _fechaNacimiento = '';
  String _altura = '';
  String _peso = '';
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime lastDate = now.subtract(const Duration(days: 365 * 18)); // Allow only users 18 years or older
    DateTime initialDate = now.isAfter(lastDate) ? lastDate : now;

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        _fechaNacimiento = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuéntame sobre ti',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF4157FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildDropdownField(),
                const SizedBox(height: 30.0), // Espaciado adicional
                _buildDateField(context),
                const SizedBox(height: 30.0), // Espaciado adicional
                _buildTextField(
                  labelText: 'Altura (cm)',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu altura';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _altura = value!;
                  },
                ),
                const SizedBox(height: 30.0), // Espaciado adicional
                _buildTextField(
                  labelText: 'Peso (kg)',
                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu peso';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _peso = value!;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(  //Boton de siguiente y guardar
                  onPressed: () {
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FormularioTrabajoApp ())
                  );  
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Datos guardados')),
                      
                      );
                      
                      // Aquí puedes manejar los datos como desees
                      print('Género: $_genero');
                      print('Fecha de Nacimiento: $_fechaNacimiento');
                      print('Altura: $_altura');
                      print('Peso: $_peso');
                    }
                  
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4157FF),
                    minimumSize: const Size(104, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    shadowColor: Colors.black.withOpacity(0.12),
                    elevation: 8,
                    padding: const EdgeInsets.all(0), // Eliminar padding predeterminado
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset('assets/images/image.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Género',
          border: InputBorder.none,
        ),
        value: _genero,
        items: ['Masculino', 'Femenino'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _genero = newValue!;
          });
        },
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    String? hintText,
    required TextInputType keyboardType,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: InputBorder.none,
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        controller: _dateController,
        decoration: const InputDecoration(
          labelText: 'Fecha de Nacimiento',
          hintText: 'dd/mm/yyyy',
          border: InputBorder.none,
        ),
        readOnly: true,
        onTap: () {
          _selectDate(context);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor ingresa tu fecha de nacimiento';
          }
          return null;
        },
        onSaved: (value) {
          _fechaNacimiento = value!;
        },
      ),
    );
  }
}