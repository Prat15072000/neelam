import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women/Shared/fonts.dart';
import 'package:women/Shared/colors.dart';
import 'package:women/Shared/widgets/buttons.dart';
import 'package:women/Shared/widgets/drawer.dart';
import 'package:women/Shared/services/crud.dart';
import 'package:women/User/others/thankyou.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name, age, phone;
  crudMethods crudObjs = crudMethods();
  QuerySnapshot rideNow;
  List userProfilesList = [];

  @override
  void initState() {
    fetchDatabaseList();
    super.initState();
  }

  fetchDatabaseList() async {
    dynamic resultant = await crudMethods().getData();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.getSecondaryColor(),
        title: Row(
          children: [
            Text(
              'Home',
              style: topic,
            ),
            SizedBox(
              width: w / 3,
            ),
            FlatButton(
              onPressed: () {},
              minWidth: w / 6,
              height: h / 20,
              color: AppColors.getPrimaryColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: AppColors.getPrimaryColor(),
                ),
              ),
              child: Text(
                'Log Out',
                style: mainTextStyle,
              ),
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Container(
          height: h / 1,
          child: Column(
            children: [
              SizedBox(
                height: h / 9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: h / 3.5,
                    width: w / 2.6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.getShadowColor(),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Icon(
                          Icons.support,
                          size: 100,
                          color: AppColors.getPrimaryColor(),
                        ),
                        SizedBox(
                          height: h / 23,
                        ),
                        Center(
                          child: Text(
                            'Register a\ncomplaint',
                            style: title,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: h / 3.5,
                    width: w / 2.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.getShadowColor(),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'images/car.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: h / 15,
                        ),
                        Text(
                          'Ride Later',
                          style: title,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h / 15,
              ),
              GestureDetector(
                onTap: () {
                  rideNowDialog(context);
                },
                child: Container(
                  height: h / 8,
                  width: w / 1.2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.getShadowColor(),
                          blurRadius: 10.0,
                        ),
                      ]),
                  child: Row(
                    children: [
                      SizedBox(
                        width: w / 10,
                      ),
                      Image.asset(
                        'images/location.png',
                        height: h / 2,
                      ),
                      SizedBox(
                        width: w / 10,
                      ),
                      Text(
                        'Ride Now',
                        style: topic,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: h / 20,
              ),
              //getRideDetails()
              Expanded(
                child: ListView.builder(
                  itemCount: userProfilesList.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(userProfilesList[i].data['name']),
                      subtitle: Text(userProfilesList[i].data['age']),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget getRideDetails() {
  //   if (rideNow != null) {
  //     return Expanded(
  //       child: ListView.builder(
  //         itemCount: userProfilesList.length,
  //         itemBuilder: (context, i) {
  //           return ListTile(
  //             title: Text(userProfilesList[i]['name']),
  //             subtitle: Text(userProfilesList[i]['age']),
  //           );
  //         },
  //       ),
  //     );
  //   }
  // }

  Future<bool> rideNowDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return Dialog(
            child: SingleChildScrollView(
              child: Container(
                height: h / 1.4,
                width: w / 1.1,
                decoration: BoxDecoration(
                  color: AppColors.getWhiteColor(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Fill this form up and we will soon\n get in touch with you',
                        style: title,
                      ),
                    ),
                    Container(
                      width: w / 2,
                      child: TextFormField(
                        onChanged: (value) {
                          this.name = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: h / 20,
                    ),
                    Container(
                      width: w / 2,
                      child: TextFormField(
                        onChanged: (value) {
                          this.age = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: h / 20,
                    ),
                    Container(
                      width: w / 2,
                      child: TextFormField(
                        onChanged: (value) {
                          this.phone = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: h / 10,
                    ),
                    ServicesButton(
                      h: h,
                      w: w,
                      text: 'Submit',
                      onTap: () {
                        // Map rideData = {};
                        crudObjs.addData({
                          'name': this.name,
                          'age': this.age,
                          'phone': this.phone,
                        }).catchError((e) {
                          print(e);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThankYou(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

// TODO: implement initState
// crudObjs.getData().then((QuerySnapshot results) {
//   setState(() {
//     rideNow = results;
//   });
// });
