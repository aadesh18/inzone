import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:fluttermoji/fluttermojiController.dart';
import 'package:fluttermoji/fluttermojiCustomizer.dart';
import 'package:fluttermoji/fluttermojiSaveWidget.dart';
import 'package:fluttermoji/fluttermojiThemeData.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main.dart';

class Charactertemp extends StatefulWidget {
  const Charactertemp({super.key});

  @override
  State<Charactertemp> createState() => _CharactertempState();
}

class _CharactertempState extends State<Charactertemp> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Character Creation"),
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     "Use your Fluttermoji anywhere\nwith the below widget",
          //     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          SizedBox(
            height: 25,
          ),
          pictureName == "7" ?
          FluttermojiCircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 100,
          ) :
          GestureDetector(
            onTap: (){
              pictureName = "6";
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Selected!'),
                ),
              );
            },
            child: Container(
                height: 120, width: 120,
                child: SvgPicture.asset('assets/$pictureName.svg')),
          ),

          SizedBox(
            height: 25,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     "and create your own page to customize them using our widgets",
          //     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Spacer(flex: 2),
              Expanded(
                flex: 3,
                child: Container(
                  height: 35,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text("Customize"),
                    onPressed: () {
                      setState(() {
                        pictureName = "7";

                      });


                      Navigator.push(context,
                        new MaterialPageRoute(builder: (context) =>  NewPage()));}
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

class NewPage extends StatelessWidget {
   NewPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: FluttermojiCircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                width: _width * 0.85,
                child: Row(
                  children: [
                    Text(
                      "Customize:",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Spacer(),
                    GestureDetector(onTap: (){


                    },child: FluttermojiSaveWidget()),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: FluttermojiCustomizer(

                  scaffoldWidth:  _width * 0.85,
                  autosave: false,

                  theme: FluttermojiThemeData(
                      boxDecoration: const BoxDecoration(boxShadow: [BoxShadow()])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
