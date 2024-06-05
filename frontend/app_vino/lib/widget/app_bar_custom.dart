import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback logout;
  final bool isLogin;

  const CustomAppBar({
    super.key,
    required this.logout,
    required this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return isLogin ? AppBar(
      backgroundColor: theme.colorScheme.primary,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(Icons.view_headline, color: theme.colorScheme.secondary),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        },
      ),
      title: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo.png',
          width: 50,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.logout_rounded,
            color: theme.colorScheme.secondary,
            size: 30,
          ),
          onPressed: logout,
        ),
      ],
    ) : AppBar(
      backgroundColor: theme.colorScheme.primary,
      title: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo.png',
          width: 50,
        ),
      ),
    ) 
    ;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
