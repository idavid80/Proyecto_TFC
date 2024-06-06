import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const  Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack, // Cambia la curva de interpolación según lo necesites
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: Image.asset('assets/images/logo.png'),
      //const Icon( //
      //  Icons.favorite,
      //  color: Colors.red,
      //  size: 100.0,
      //), 370 air china
      //ida y vuelta 585
      
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heartbeat Animation'),
      ),
      body: const Center(
        
        child: Logo(),
      ),
    );
  }
}

