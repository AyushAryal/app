import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 250, 246, 250)),
        child: Column(
          children: const [
            SizedBox(height: 10),
            ButtonGroup(),
            SizedBox(height: 10),
            CallLog(),
            SizedBox(height: 10),
            RadioSection(),
          ],
        ),
      ),
    );
  }
}

class CallLog extends StatefulWidget {
  const CallLog({super.key});

  @override
  State<CallLog> createState() => _CallLogState();
}

class _CallLogState extends State<CallLog> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    Widget toggle_button = OutlinedButton(
        onPressed: () {
          setState(() {
            expanded = !expanded;
          });
        },
        child: Icon(expanded ? Icons.arrow_upward : Icons.arrow_downward));

    Widget actual_widget = Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "11:50 AM",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Incoming Call",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("2 minutes"),
                  ],
                )
              ],
            ),
            toggle_button,
          ],
        ),
      ),
    );
    return expanded ? actual_widget : toggle_button;
  }
}

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Expanded(
          child: SimpleButton(label: "Call", icon: Icons.phone, active: true),
        ),
        Expanded(
          child:
              SimpleButton(label: "Message", icon: Icons.message, active: true),
        ),
        Expanded(
          child: SimpleButton(
              label: "Video", icon: Icons.video_call, active: true),
        ),
        Expanded(
          child: SimpleButton(label: "Mail", icon: Icons.mail, active: false),
        ),
      ],
    );
  }
}

class SimpleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;

  const SimpleButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.active});

  @override
  Widget build(BuildContext context) {
    Widget button = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          Text(label),
        ],
      ),
    );
    return OutlinedButton(
      onPressed: active ? () => {debugPrint("$label was pressed")} : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 255, 255, 255)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: button,
    );
  }
}

enum myList { mac, linux }

class RadioOpt extends StatefulWidget {
  const RadioOpt({super.key});

  @override
  State<RadioOpt> createState() => _RadioOptState();
}

class _RadioOptState extends State<RadioOpt> {
  myList? _character = myList.mac;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text(
            style: TextStyle(color: Color.fromARGB(255, 70, 70, 70)),
            'Mac',
          ),
          leading: Radio<myList>(
            splashRadius: 50,
            activeColor: const Color.fromARGB(255, 24, 114, 126),
            focusColor: const Color.fromARGB(255, 236, 184, 25),
            value: myList.mac,
            groupValue: _character,
            onChanged: (myList? value) {
              setState(() {
                _character = value;
                debugPrint('$value');
              });
            },
          ),
        ),
        ListTile(
          title: const Text(
            style: TextStyle(color: Color.fromARGB(255, 70, 70, 70)),
            'Linux',
          ),
          leading: Radio<myList>(
            splashRadius: 50,
            activeColor: const Color.fromARGB(255, 24, 114, 126),
            focusColor: const Color.fromARGB(255, 236, 184, 25),
            value: myList.linux,
            groupValue: _character,
            onChanged: (myList? value) {
              setState(() {
                _character = value;
                debugPrint('$value');
              });
            },
          ),
        ),
      ],
    );
  }
}

class RadioSection extends StatelessWidget {
  const RadioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 188, 166, 226)),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 30,
              color: Color.fromARGB(255, 18, 43, 85),
            ),
            "Radio Section",
          ),
          RadioOpt(),
        ],
      ),
    );
  }
}
