import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;

import '../data/database.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      color: Colors.white,
      padding: const EdgeInsets.only(right: 20),
      tooltip: 'Settings',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return newPage();
            },
          ),
        );
      },
    );
  }

  newPage() {
    final database = Provider.of<MoorDatabase>(context, listen: false);
    return StreamBuilder<int>(
        stream: ThemeColorsDao(database).getColorQuery(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          var color = snapshot.data;
          color ??= -15632662;
          return Scaffold(
            backgroundColor: Color(color),
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: Color(color),
                title: const Text('Settings', style: TextStyle(fontSize: 30)),
                elevation: 0),
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                color: Colors.white,
              ),
              child: Column(children: [
                const Text(
                  'Choose color theme',
                  style: TextStyle(fontSize: 25),
                ),
                chooseColor(),
              ]),
            ),
          );
        });
  }

  chooseColor() {
    final database = Provider.of<MoorDatabase>(context, listen: false);
    return StreamBuilder(
        stream: ThemeColorsDao(database).watchSelectColors(),
        builder: (context, AsyncSnapshot<List<ThemeColor>> snapshot) {
          final colors = snapshot.data ?? [];
          return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150),
              itemCount: colors.length,
              itemBuilder: (BuildContext ctx, index) {
                return IconButton(
                  icon: iconState(colors[index]),
                  onPressed: () {
                    changeStateOfColors(colors[index], colors);
                  },
                );
              });
        });
  }

  void changeStateOfColors(ThemeColor color, List<ThemeColor> colors) {
    final database = Provider.of<MoorDatabase>(context, listen: false);
    for (ThemeColor colorFromDB in colors) {
      if (colorFromDB == color) {
        ThemeColorsDao(database)
            .updateColor(colorFromDB.copyWith(selected: true));
      } else {
        ThemeColorsDao(database)
            .updateColor(colorFromDB.copyWith(selected: false));
      }
    }
  }

  iconState(ThemeColor color) {
    if (color.selected) {
      return Icon(
        Icons.check_circle,
        size: 130,
        color: Color(color.colorName),
      );
    }
    return Icon(
      Icons.circle,
      size: 130,
      color: Color(color.colorName),
    );
  }
}
