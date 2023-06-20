import 'package:app/servicees/userAPI.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
class updateUserForm extends StatefulWidget {
  final User user;
  const updateUserForm(this.user,{super.key});

  @override
  State<updateUserForm> createState() => _updateUserFormState();
}

class _updateUserFormState extends State<updateUserForm> {
  var _userNameController = TextEditingController();
  var _userContactController = TextEditingController();

  bool _validateName = false;
  bool _validateContact = false;
@override
void insitState(){
  _userNameController.text=widget.user.name;
  _userContactController.text=widget.user.contact;
}
  @override
  Widget build(BuildContext context) {
    insitState();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update User!"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                ' Update User',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Name",
                  labelText: "Name",
                  errorText:
                  _validateName ? 'Naame Vlaue can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userContactController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Cantact",
                  labelText: "Contact",
                  errorText:
                  _validateContact ? 'Cantact Vlaue can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _userContactController.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                        });
                        if(_validateName==false && _validateContact ==false){

                          var result=await UserApi().updateUser(_userNameController.text, _userContactController.text,widget.user.id);
                          Navigator.pop(context,result);
                        }
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(fontSize: 15)),
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 20.0,
                  ),
                  TextButton(
                      onPressed: () {
                        _userNameController.text = "";
                        _userContactController.text = "";
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
