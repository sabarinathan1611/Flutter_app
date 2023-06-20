import 'package:app/view/addUserForm.dart';
import 'package:app/view/updateUserForm.dart';
import 'package:flutter/material.dart';
import 'package:app/models/user.dart';
import 'package:app/servicees/userAPI.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User>? users;
  var isLoaded = false;

  @override
  void initState() {
    getRecord();
  }

  getRecord() async {
    users = await UserApi().getAllUser();
    if (users != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Future<void> showMessageDialog(String title, String msg) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(msg),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'))
            ],
          );
        });
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('FLask RestAPI'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(

            itemCount: users?.length,
            itemBuilder: (context, index) {
              return Container(

                child: ListTile(
                  title: Text("User Name: ${users![index].name}"),

                  subtitle: Text("Contact : ${users![index].contact}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async{
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => updateUserForm(users![index])))
                              .then((data) {
                            if (data != null) {
                              showMessageDialog("Success","$data Updated :)");
                              getRecord();
                            }
                          });
                        },
                        icon: const Icon(Icons.edit,color: Colors.blue,),//Edit button
                      ),
                      IconButton(
                        onPressed: () async{
                          User user = await UserApi().deleteUser(users![index].id);
                          showMessageDialog("Success","$user  was Deleted :)");
                          getRecord();

                        },
                        icon: const Icon(Icons.delete,color: Colors.red,),//Delete Button
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const addUserForm()))
              .then((data) {
            if (data != null) {
              showMessageDialog("Success","$data Added :)");
              getRecord();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
