import 'package:flutter/material.dart';
import 'package:inzone/main_screens/post_screen.dart';
import 'package:inzone/main_screens/settings_screens/components/settings_page_skeleton.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SettingsPageSkeleton(
      title: "Profile",
      subtitle: "",
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0), // Adjust the radius as needed
            topRight: Radius.circular(40.0),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset:
                          const Offset(0, 0), // Changes the position of the shadow
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Gender",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            gender = 0;
                          });
                        },
                        child: genderChoose(Icons.male, "Male", 0)),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            gender = 1;
                          });
                        },
                        child: genderChoose(Icons.male, "Female", 1)),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            gender = 2;
                          });
                        },
                        child: genderChoose(Icons.male, "Other", 2)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Age",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset:
                          const Offset(0, 0), // Changes the position of the shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: 200,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                        child: Row(
                      children: [
                        age == index + 1
                            ? Container(
                                margin: const EdgeInsets.only(left: 5, right: 5),
                                width: 30.0,
                                height: 30.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors
                                      .blue, // You can change the color as needed
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 0,
                                      spreadRadius: 0,
                                      color: Color(0xFF1573BE),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}', // Your content or icon goes here
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    age = index + 1;
                                  });
                                },
                                child: Text("   ${index + 1}   ")),
                      ],
                    ));
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Parents Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset:
                          const Offset(0, 0), // Changes the position of the shadow
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter parents email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.5,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: const Text(
                          "I have read the terms and condition and \nI accept the general conditions of use.",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500))),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50.0,
                  margin: const EdgeInsets.only(bottom: 20, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(46.0),
                    border: Border.all(
                      width: 1.0,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int age = 4;
  int gender = 0;
  bool isChecked = false;

  Widget genderChoose(IconData iconData, String genderName, int index) {
    return SizedBox(
      height: 60,
      // width: 110,
      width: MediaQuery.of(context).size.width / 3.4,
      child: Stack(
        children: [
          Container(
            // width: 110,
            height: 48,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: gender != index
                      ? Colors.grey.withOpacity(0.5)
                      : Colors.blue,
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(0, 2), // Changes the position of the shadow
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconData,
                    color: gender != index ? Colors.black54 : Colors.blue,
                  ),
                  Text(
                    genderName,
                    style: TextStyle(
                      color: gender != index ? Colors.black : Colors.blue,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          gender != index
              ? Container()
              : const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 20,
                  )),
        ],
      ),
    );
  }
}
