import 'package:flutter/material.dart';
import 'package:pomo_coco_website/managers/twitch_manager.dart';
import 'package:pomo_coco_website/screens/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitch_manager/twitch_manager.dart' as tm;

class ConnectedStreamersPage extends StatefulWidget {
  const ConnectedStreamersPage({super.key});

  static const route = '/connect-streamers-page';

  @override
  State<ConnectedStreamersPage> createState() => _ConnectedStreamersPageState();
}

class _ConnectedStreamersPageState extends State<ConnectedStreamersPage> {
  final List<TextEditingController> _streamerControllers = [];

  @override
  void initState() {
    super.initState();
    _reloadStreamers();
  }

  Future<void> _reloadStreamers() async {
    final preferences = await SharedPreferences.getInstance();
    final listOfStreamers = preferences.getStringList('streamers') ?? [];
    for (final streamer in listOfStreamers) {
      _addStreamerToControllers(streamer);
    }

    setState(() {});
  }

  void _addStreamerToControllers([String? id]) {
    _streamerControllers.add(
        TextEditingController(text: id)..addListener(() => _saveStreamers()));
  }

  @override
  void dispose() {
    for (final controller in _streamerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _saveStreamers() async {
    final preferences = await SharedPreferences.getInstance();
    final listOfStreamers = <String>[];
    for (final controller in _streamerControllers) {
      if (controller.text.isEmpty) continue;
      listOfStreamers.add(controller.text);
    }
    preferences.setStringList('streamers', listOfStreamers);
  }

  void _connectStreamer({required String saveId}) async {
    final manager = await showDialog<tm.TwitchManager>(
      context: context,
      builder: (context) => Dialog(
          child: tm.TwitchAuthenticationScreen(
        isMockActive: TwitchManager.instance.useMock,
        debugPanelOptions: TwitchManager.instance.debugOptions,
        onFinishedConnexion: (manager) => Navigator.pop(context, manager),
        appInfo: TwitchManager.instance.appInfo,
        saveKey: saveId,
        reload: true,
      )),
    );
    if (!mounted || manager == null) return;

    await TwitchManager.instance.addStreamer(id: saveId, manager: manager);
    if (!mounted) return;

    _saveStreamers();
    if (_streamerControllers.isNotEmpty &&
        TwitchManager.instance.streamerIds.length ==
            _streamerControllers.length) {
      Navigator.of(context).pushReplacementNamed(MainPage.route);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              Text(
                'Connect the streamers',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(height: 12),
              for (int i = 0; i < _streamerControllers.length; i++)
                _buildStreamerButton(streamerIndex: i),
              const SizedBox(height: 24),
              _buildAddStreamer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddStreamer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Add a streamer',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(width: 12),
        InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () => setState(() => _addStreamerToControllers()),
          child: const Icon(Icons.add_circle_outlined,
              color: Colors.green, size: 35),
        ),
      ],
    );
  }

  Widget _buildStreamerButton({required int streamerIndex}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
            width: 350,
            child: TextField(
              decoration: const InputDecoration(labelText: 'Streamer save id'),
              controller: _streamerControllers[streamerIndex],
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: TwitchManager.instance.streamerIds
                          .contains(_streamerControllers[streamerIndex].text)
                      ? null
                      : () => _connectStreamer(
                          saveId: _streamerControllers[streamerIndex].text),
                  child: Text('Connect streamer ${streamerIndex + 1}')),
              const SizedBox(width: 4),
              InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () => setState(() {
                  _streamerControllers.removeAt(streamerIndex);
                  _saveStreamers();
                }),
                child: const SizedBox(
                  width: 35,
                  height: 35,
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
