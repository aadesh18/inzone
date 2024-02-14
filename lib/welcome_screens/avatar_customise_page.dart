//import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:o3d/o3d.dart';

class AvatarCustomisePage extends StatefulWidget {
  const AvatarCustomisePage({Key? key}) : super(key: key);

  @override
  State<AvatarCustomisePage> createState() => _AvatarCustomisePageState();
}

class _AvatarCustomisePageState extends State<AvatarCustomisePage> {
  O3DController controller = O3DController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffdaf5ff),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 40),
              //   child: Container(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         IconButton(
              //           onPressed: () {},
              //           icon: Icon(Icons.close),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(left: 50),
              //           child: Text(
              //             "Avatar",
              //             style: TextStyle(
              //               fontSize: 27,
              //               color: Colors.black,

              //               // fontWeight: FontWeight.bold
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(right: 10),
              //           child: Container(
              //             height: 30,
              //             width: 90,
              //             decoration: BoxDecoration(
              //                 color: Colors.blue,
              //                 borderRadius: BorderRadius.circular(50)),
              //             child: Column(
              //               children: [
              //                 Center(
              //                   child: Text(
              //                     "Save",
              //                     style: TextStyle(
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 18),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    Container(
                      height: 297,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/3D/back.png'),
                              fit: BoxFit.cover),
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(width: 5, color: Colors.blue),
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: Column(
                        children: [
                          Container(
                            height: 257,
                            width: 111,
                            decoration: const BoxDecoration(
                                //color: Colors.pink,
                                // image: DecorationImage(
                                //     image: AssetImage('assets/3D/ava.png'),
                                //     fit: BoxFit.fill),
                                ),
                            child: Center(
                              child: O3D.asset(
                                src: 'assets/3D/characters_7.glb',
                                controller: controller,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      height: 30,
                                      width: 120,
                                      decoration: const BoxDecoration(
                                        // color: Colors.blue,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/3D/drum.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 120,
                                    decoration: const BoxDecoration(
                                      // color: Colors.blue,
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/3D/side.png'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 220),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                //color: Colors.blue,
                                // borderRadius: BorderRadius.circular(10),
                                //border: Border.all(width: 3, color: Colors.blue),
                                image: DecorationImage(
                                    image: AssetImage('assets/3D/back11.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                //color: Colors.blue,
                                // borderRadius: BorderRadius.circular(10),
                                //border: Border.all(width: 3, color: Colors.blue),
                                image: DecorationImage(
                                    image: AssetImage('assets/3D/back1.png'),
                                    fit: BoxFit.cover),
                              ),
                              child: const Center(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Select Your Avatar",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10),
                  //   child: Text(
                  //     "Shoes",
                  //     style: TextStyle(color: Colors.blue),
                  //   ),
                  // )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      border: const Border(
                        bottom: BorderSide(width: 4, color: Colors.blue),
                        left: BorderSide(width: 1, color: Colors.blue),
                        right: BorderSide(width: 1, color: Colors.blue),
                        top: BorderSide(width: 1, color: Colors.blue),
                      ),
                    ),
                    child: Center(
                      child: O3D.asset(
                        src: 'assets/3D/characters_7.glb',
                        controller: controller,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      border: const Border(
                        bottom: BorderSide(width: 4, color: Colors.blue),
                        left: BorderSide(width: 1, color: Colors.blue),
                        right: BorderSide(width: 1, color: Colors.blue),
                        top: BorderSide(width: 1, color: Colors.blue),
                      ),
                    ),
                    child: Center(
                      child: O3D.asset(
                        src: 'assets/3D/characters_7.glb',
                        controller: controller,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      border: const Border(
                        bottom: BorderSide(width: 4, color: Colors.blue),
                        left: BorderSide(width: 1, color: Colors.blue),
                        right: BorderSide(width: 1, color: Colors.blue),
                        top: BorderSide(width: 1, color: Colors.blue),
                      ),
                    ),
                    child: Center(
                      child: O3D.asset(
                        src: 'assets/3D/characters_7.glb',
                        controller: controller,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      border: const Border(
                        bottom: BorderSide(width: 4, color: Colors.blue),
                        left: BorderSide(width: 1, color: Colors.blue),
                        right: BorderSide(width: 1, color: Colors.blue),
                        top: BorderSide(width: 1, color: Colors.blue),
                      ),
                    ),
                    child: Center(
                      child: O3D.asset(
                        src: 'assets/3D/characters_7.glb',
                        controller: controller,
                      ),
                    ),
                  )
                ],
              ),
              // SizedBox(
              //   height: 7,
              // ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(
              //         left: 20,
              //       ),
              //       child: Container(
              //           height: 150,
              //           width: 150,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(25),
              //             color: Colors.white,
              //             border: Border(
              //               bottom: BorderSide(width: 4, color: Colors.blue),
              //               left: BorderSide(width: 1, color: Colors.blue),
              //               right: BorderSide(width: 1, color: Colors.blue),
              //               top: BorderSide(width: 1, color: Colors.blue),
              //             ),
              //           ),
              //           child: Column(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.only(top: 30),
              //                 child: Container(
              //                   height: 80,
              //                   width: 80,
              //                   decoration: BoxDecoration(
              //                       // color: Colors.black,
              //                       ),
              //                 ),
              //               ),
              //             ],
              //           )),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(
              //         left: 15,
              //       ),
              //       child: Container(
              //         height: 150,
              //         width: 150,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(25),
              //           color: Colors.white,
              //           border: Border(
              //             bottom: BorderSide(width: 4, color: Colors.blue),
              //             left: BorderSide(width: 1, color: Colors.blue),
              //             right: BorderSide(width: 1, color: Colors.blue),
              //             top: BorderSide(width: 1, color: Colors.blue),
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 7,
              // ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 75,
      //   width: double.infinity,
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      //   child: Padding(
      //     padding: const EdgeInsets.all(15),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         Container(
      //           height: 90,
      //           width: 40,
      //           decoration: BoxDecoration(
      //             // color: Colors.amber,
      //             borderRadius: BorderRadius.circular(10),
      //             image: DecorationImage(
      //                 image: AssetImage('assets/3D/first.png'),
      //                 fit: BoxFit.cover),
      //           ),
      //           child: Center(
      //             child: Container(
      //               height: 10,
      //               width: 20,
      //               decoration: BoxDecoration(
      //                 // color: Colors.white,
      //                 image: DecorationImage(
      //                     image: AssetImage('assets/3D/sho.png'),
      //                     fit: BoxFit.cover),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Container(
      //           height: 90,
      //           width: 40,
      //           decoration: BoxDecoration(
      //             // color: Colors.amber,
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           child: Center(
      //             child: Container(
      //               height: 30,
      //               width: 30,
      //               decoration: BoxDecoration(
      //                 // color: Colors.white,
      //                 image: DecorationImage(
      //                     image: AssetImage('assets/3D/shirt.png'),
      //                     fit: BoxFit.cover),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Container(
      //           height: 90,
      //           width: 40,
      //           decoration: BoxDecoration(
      //             // color: Colors.amber,
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           child: Center(
      //             child: Container(
      //               height: 30,
      //               width: 30,
      //               decoration: BoxDecoration(
      //                 // color: Colors.white,
      //                 image: DecorationImage(
      //                     image: AssetImage('assets/3D/pant.png'),
      //                     fit: BoxFit.cover),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Container(
      //           height: 90,
      //           width: 40,
      //           decoration: BoxDecoration(
      //             // color: Colors.amber,
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           child: Center(
      //             child: Container(
      //               height: 30,
      //               width: 30,
      //               decoration: BoxDecoration(
      //                 // color: Colors.white,
      //                 image: DecorationImage(
      //                     image: AssetImage('assets/3D/cap.png'),
      //                     fit: BoxFit.cover),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Container(
      //           height: 90,
      //           width: 40,
      //           decoration: BoxDecoration(
      //             // color: Colors.amber,
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           child: Center(
      //             child: Container(
      //               height: 30,
      //               width: 30,
      //               decoration: BoxDecoration(
      //                 // color: Colors.white,
      //                 image: DecorationImage(
      //                     image: AssetImage('assets/3D/last.png'),
      //                     fit: BoxFit.cover),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
