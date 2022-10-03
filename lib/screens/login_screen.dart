import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/helpers/custom_colors.dart';
import 'package:productos_app/providers/login_form_providers.dart';
import 'package:productos_app/ui/input_decoration.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 200),
          CardContainer(
              child: Column(
            children: [
              const Text(
                'Login',
                style: TextStyle(
                    color: CustomColors.darkBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
              const SizedBox(height: 24),
              ChangeNotifierProvider(
                create: (_) => LogginFormProvider(),
                child: _LoginForm(),
              )
            ],
          )),
          const SizedBox(height: 64),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, 'register'),
            child: const Text(
              'Crear una cuenta',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LogginFormProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                style: const TextStyle(color: CustomColors.darkBlue),
                enabled: !loginForm.isLoading,
                onChanged: (value) => loginForm.email = value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecorations(
                    label: 'Correo Electrónico',
                    placeholder: 'mail@mail.com',
                    icono: Icons.alternate_email),
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Formato Incorrecto';
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                autocorrect: false,
                style: const TextStyle(color: CustomColors.darkBlue),
                enabled: !loginForm.isLoading,
                onChanged: (value) => loginForm.password = value,
                obscureText: true,
                decoration: InputDecorations.authInputDecorations(
                    label: 'Contraseña',
                    placeholder: '********',
                    icono: Icons.lock),
                validator: (value) {
                  if (value != null && value.length >= 6) return null;
                  return 'La contraseña debe contener más de 6 caracteres';
                },
              ),
              const SizedBox(height: 24),
              MaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: CustomColors.lightBlue,
                disabledColor: Colors.grey,
                elevation: 0,
                onPressed: !loginForm.isLoading
                    ? () async {
                        FocusScope.of(context).unfocus();
                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;
                        await Future.delayed(const Duration(seconds: 3));
                        loginForm.isLoading = false;

                        Navigator.pushReplacementNamed(context, 'home');
                      }
                    : null,
                child: Container(
                    child: !loginForm.isLoading
                        ? const Text('Iniciar Sesión',
                            style: TextStyle(color: Colors.white))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Cargando',
                                style: TextStyle(color: Colors.white54),
                              ),
                              const SizedBox(width: 12),
                              Transform.scale(
                                  scale: 0.5,
                                  child: const CircularProgressIndicator(
                                      color: Colors.white54))
                            ],
                          )),
              )
            ],
          )),
    );
  }
}
