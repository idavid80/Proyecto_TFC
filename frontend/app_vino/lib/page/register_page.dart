import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vino/main.dart';
import 'package:app_vino/services/ory_services.dart';
import 'package:app_vino/widget/google_button.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String mensaje = 'nana';

  void _register() async {
    OryServices ory = OryServices();
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      String email = _emailController.text;

      final isRegister = await ory.register(username, email, password);

      notification(isRegister);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    }
  }

  void notification(bool isRegister) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isRegister) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Bienvenido ${prefs.getString("email")}')),
      );
    } else {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('Usuario no registrado o contraseña incorrecta'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(mensaje),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                obscureText: _passwordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _register,
                child: const Text('register'),
              ),
              
              const SignInWithGoogleButton(),
            ],
          ),
        ),
      ),
    );
  }
}

/*

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes agregar la lógica de autenticación
      String username = _usernameController.text;
      String password = _passwordController.text;

      final checkLogin = await OryServices().login(username, password);
      if (checkLogin.statusCode! >= 200 && checkLogin.statusCode! <= 299) {
        setState(() {
          _islogin = true;
        });
      //  ScaffoldMessenger.of(context).showSnackBar(
        //  const SnackBar(
          //    content: Text('Usuario registrado, iniciando sesión...')),
      //  );
      } else {
        setState(() {
          _islogin = false;
        });
     //   ScaffoldMessenger.of(context).showSnackBar(
       //   const SnackBar(
          //    content: Text('Usuario no registrado o contraseña incorrecta')),
       // );
      }
    }
  }
 */