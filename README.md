# pomo_coco_website

Le site officiel du PomoCoco-48h Relais!

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Firebase

1. Installer le [CLI Firebase](https://firebase.google.com/docs/cli#setup_update_cli). La façon la plus rapide, si Node.js est déjà installé, est avec `npm` :    

        npm install -g firebase-tools

2. Installer le [CLI FlutterFire](https://pub.dev/packages/flutterfire_cli) à l'aide de `dart`.

        dart pub global activate flutterfire_cli

3. Se connecter avec un compte ayant accès au projet Firebase et configurer le projet avec les paramètres par défaut.

        firebase login
        flutterfire configure --project=multi-twitch-streamers

Pour plus d'informations, visitez [cette page](https://firebase.google.com/docs/flutter/setup).

4. To initialize emulators, you can run the following command:
        firebase init

5. After that, to run the emulator service, you must run the command:
        firebase emulators:start

        