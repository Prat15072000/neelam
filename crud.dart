import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class crudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(rideData) async {
    if (isLoggedIn()) {
      FirebaseFirestore.instance
          .collection('Ride Now Details')
          .add(rideData)
          .catchError((e) {
        print(e);
      });
    } else {
      print("I believe user is not found");
    }
  }

  // getData() async {
  //   return await FirebaseFirestore.instance
  //       .collection('Ride Now Details')
  //       .get();
  // }
  Future getData() async {
    List itemsList = [];
    final CollectionReference profileList =
        FirebaseFirestore.instance.collection('Ride Now Details');
    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
