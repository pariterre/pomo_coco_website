import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomo_coco_website/screens/connect_streamers_page.dart';

class AdministrationLoginPage extends StatefulWidget {
  const AdministrationLoginPage({super.key});

  static const String route = '/server-login-page';

  @override
  State<AdministrationLoginPage> createState() =>
      _AdministrationLoginPageState();
}

class _AdministrationLoginPageState extends State<AdministrationLoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
    // If the user is already signed in, redirect to the ConnectStreamersPage
    if (_auth.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(ConnectStreamersPage.route);
      });
    }
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        if (!mounted) return;
        Navigator.of(context).pushNamed(ConnectStreamersPage.route);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Connexion échouée')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Connexion à l\'administration de la base de donnée',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24)),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Courriel'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'SVP entrez votre courriel';
                    }

                    // If the provided email is not valid using the regex pattern
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'SVP entrez un courriel valide';
                    }

                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'SVP entrez votre mot de passe';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _signIn,
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
