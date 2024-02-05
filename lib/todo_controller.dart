import 'package:flutter/widgets.dart';
import 'package:crud_project/todo_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactController extends GetxController{
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  final db = FirebaseFirestore.instance;
  var contactList = RxList<ContactModel>();
  int idNo = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getContact();
  }

  void deleteContact(String id) async {
    try {
      QuerySnapshot querySnapshot = await db.collection("contact").get();
      for (var documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.delete();
      }
      contactList.removeWhere((element) => element.id == id);
      for (var contact in contactList) {
        await db.collection("contact").add(contact.toJson());
      }
    }catch (e) {
      print("error deleting contact: $e");
    }
  }

  void addContact() async {
    try {
      var contact = ContactModel(
        name: name.text,
        number: number.text,
        id: db.collection("contact").doc().id,
      );

      await db.collection("contact").doc(contact.id).set(contact.toJson());

      printInfo(info: "Contact Added");
      getContact();
      name.clear();
      number.clear();
    } catch (e) {
      print("Error adding contact: $e");
    }
  }

  void getContact() async {
    var conacts = await db.collection("contact").get();
    contactList.clear();
      for (var contact in conacts.docs) {
        contactList.add(ContactModel.fromJson(contact.data(),),);
      }
    print("Get Contact");
  }

  void updateContact(String id, String newName, String newNumber) async {
    try {
      var index = contactList.indexWhere((element) => element.id == id);

      if (index != -1) {
        var updatedContact = ContactModel(
          id: id,
          name: newName,
          number: newNumber,
        );

        var contactDoc = await db.collection("contact").doc(id).get();
        if (contactDoc.exists) {
          await db.collection("contact").doc(id).update(updatedContact.toJson());

          contactList[index] = updatedContact;

          printInfo(info: "Kontak Diperbarui");
          name.clear();
          number.clear();
        } else {
          print("Dokumen kontak dengan ID $id tidak ditemukan di Firestore");
        }
      } else {
        print("Kontak tidak ditemukan");
      }
    } catch (e) {
      print("Error updating contact: $e");
    }
  }






}