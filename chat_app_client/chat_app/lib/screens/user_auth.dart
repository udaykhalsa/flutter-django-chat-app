import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

import '/providers/user_authorization_provider.dart';

class AuthorizationButtons extends StatelessWidget {
  final String fieldName;
  final TextEditingController textEditingController;

  const AuthorizationButtons(
      {super.key,
      required this.fieldName,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      autocorrect: false,
      autofocus: true,
      decoration: InputDecoration(
        hintText: fieldName,
        filled: true,
        hintStyle: const TextStyle(color: Colors.black54),
        fillColor: Colors.white54,
        contentPadding: const EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}

class AuthorizationContainer extends StatelessWidget {
  final Widget childWidget;

  const AuthorizationContainer({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromRGBO(245, 117, 106, 1),
            Colors.orangeAccent.shade100,
            Colors.orangeAccent.shade100,
            Colors.orangeAccent.shade100,
            Colors.grey.shade100
          ],
        ),
      ),
      child: childWidget,
    );
  }
}

class AuthorizationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AuthorizationAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 80,
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

var userData = {};

final TextEditingController usernameController = TextEditingController();
final TextEditingController emailIDController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserRegistrationProvider userRegistrationProvider =
      UserRegistrationProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthorizationAppBar(),
      body: ChangeNotifierProvider<UserRegistrationProvider>(
        create: (context) => userRegistrationProvider,
        child: Consumer<UserRegistrationProvider>(
          builder: (context, provider, child) {
            if (provider.loginMessage == 'User registered successfully.') {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage(),
                          maintainState: true),
                      (Route<dynamic> route) => false);
                },
              );
            } else {
              return AuthorizationContainer(
                childWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Let's get you started",
                        style: TextStyle(fontSize: 26.0),
                      ),
                      AuthorizationButtons(
                        fieldName: 'Username',
                        textEditingController: usernameController,
                      ),
                      AuthorizationButtons(
                        fieldName: 'Email ID',
                        textEditingController: emailIDController,
                      ),
                      AuthorizationButtons(
                        fieldName: 'Name',
                        textEditingController: nameController,
                      ),
                      AuthorizationButtons(
                        fieldName: 'Password',
                        textEditingController: passwordController,
                      ),
                      AuthorizationButtons(
                        fieldName: 'Confirm Password',
                        textEditingController: confirmPasswordController,
                      ),
                      Text(
                        provider.loginMessage,
                        style: const TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: const Size(250, 50),
                          primary: Colors.white,
                        ),
                        child: const Text('Sign Up'),
                        onPressed: () {
                          userData = {
                            'username': usernameController.text,
                            'email_id': emailIDController.text,
                            'name': nameController.text,
                            'password': passwordController.text,
                            'confirm_password': confirmPasswordController.text,
                          };
                          userRegistrationProvider.registerUser(userData);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserLoginProvider userLoginProvider = UserLoginProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthorizationAppBar(),
      body: ChangeNotifierProvider(
        create: (context) => userLoginProvider,
        child: Consumer<UserLoginProvider>(
          builder: (context, provider, child) {
            if (provider.loginMessage == 'User logged in successfully.') {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage(),
                          maintainState: true),
                      (Route<dynamic> route) => false);
                },
              );
            } else {
              return AuthorizationContainer(
                childWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Welcome Back",
                        style: TextStyle(fontSize: 26.0),
                      ),
                      AuthorizationButtons(
                        fieldName: 'Username',
                        textEditingController: usernameController,
                      ),
                      AuthorizationButtons(
                        fieldName: 'Password',
                        textEditingController: passwordController,
                      ),
                      Text(provider.loginMessage),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: const Size(250, 50),
                          primary: Colors.white,
                        ),
                        child: const Text('Login'),
                        onPressed: () {
                          userData = {
                            'username': usernameController.text,
                            'password': passwordController.text,
                          };
                          userLoginProvider.loginUser(userData);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}


// class LoginRegisterPage extends StatefulWidget {
//   const LoginRegisterPage({Key? key}) : super(key: key);

//   @override
//   State<LoginRegisterPage> createState() => _LoginRegisterPageState();
// }

// class _LoginRegisterPageState extends State<LoginRegisterPage> {
//   final UserLoginProvider userLoginProvider = UserLoginProvider();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         OutlinedButton(
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (BuildContext context) => const RegisterPage(),
//               ),
//             );
//           },
//           child: const Text('Register'),
//         ),
//         OutlinedButton(
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (BuildContext context) => const LoginPage(),
//               ),
//             );
//           },
//           child: const Text('Login'),
//         ),
//       ],
//     );
//   }
// }