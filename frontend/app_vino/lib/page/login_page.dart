import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vino/main.dart';
import 'package:app_vino/services/ory_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String mensaje = 'nana';

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes agregar la lógica de autenticación
      String email = _emailController.text;
      String password = _passwordController.text;

      final bool checkLogin = await OryServices().login(email, password);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bienvenido ${prefs.getString("email")}')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
           if (!checkLogin) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario o contraseña incorrecto')),
        );
      }
    }
  }

  void obtenerDatos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mensaje =
          "id: ${prefs.get("userID")}. email: ${prefs.get('email')} token= ${prefs.get('token')}";
    });
  }

  void eliminarDatos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      mensaje = "Datos eliminados";
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                decoration: InputDecoration(  
                  
                  
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),              
                  suffixIcon: Icon(Icons.person, color: theme.colorScheme.primary,),
             
                  labelText: 'Email'),
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
                   fillColor: Colors.red,
                  border: OutlineInputBorder(
                   
                    borderRadius: BorderRadius.circular(5)),              

                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      color: theme.colorScheme.primary,
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
                obscureText: !_passwordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      )
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vono_app/main.dart';
import 'package:vono_app/services/ory_client.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String mensaje = 'nana';

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes agregar la lógica de autenticación
      String username = _usernameController.text;
      String password = _passwordController.text;

      final bool checkLogin = await OryServices().login(username, password);

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      SnackBar(content: Text('Bienvenido ${prefs.getString("email")}'));
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      });
    } else {
      const SnackBar(content: Text('Usuario o contraseña incorrecto'));
    }
  }

  void obtenerDatos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mensaje =
          "id: ${prefs.get("userID")}. email: ${prefs.get('email')} token= ${prefs.get('token')}";
    });
  }

  void eliminarDatos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.clear();
    });
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
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Email'),
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
              Text(mensaje),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: obtenerDatos,
                child: const Text('obtenerDatos'),
              ),
              ElevatedButton(
                onPressed: eliminarDatos,
                child: const Text('eleminar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/