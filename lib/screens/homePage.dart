import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/mynote.dart';

import '../notes_Model/notesModel.dart';
import 'colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference notes = FirebaseFirestore.instance.collection("notes");
  TextEditingController controller = TextEditingController();
  List<Notes> notesList = [];
  getRndomColor() {
    Random random = Random();
    return backGroundColors[random.nextInt(backGroundColors.length)];
  }
  
  deletenote(id) async  {
    setState(()  {
      FirebaseFirestore.instance.collection("notes").doc(id).delete();
      

    }
      );
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: notes.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // for (int i = 0; i < snapshot.data!.docs.length; i++) {
            //   notesList.add(Notes.fromJson(snapshot.data!.docs[i]));
            // }
            return Scaffold(

              body: Stack(children:[ 
                

                // Container(height:double.infinity,child: Image.asset("assets/OIP (1).jpg",fit: BoxFit.contain,),),
                
                
                Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(
                                255, 213, 137, 211),
                            Color.fromARGB(
                                255, 119, 195, 201),
                          ])
                      ),
                      child: const Text(
                        "To Do List ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Row(children: [
                      Text(
                        "All To Dos",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        child: Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 100,
                                  child: Card(
                                    elevation: 4,
                                    color: getRndomColor(),
                                    child: ListTile(
                                      title: Mynote(notes:Notes.fromJson(snapshot.data!.docs[index])),

                                      trailing: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContextcontext) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  icon: Icon(Icons.info),
                                                  title: Text(
                                                    "Are You sure  you want to Delete this Note ?",style: TextStyle(fontSize: 15),),
                                                  actions: [
                                                    Row(
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              deletenote(
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id,
                                                              );
                                                              Navigator.pop(
                                                                  context);






                                                            });
                                                          },
                                                          child: Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                              backgroundColor:
                                                              Colors
                                                                  .green),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "No",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                              backgroundColor:
                                                              Colors.red),
                                                        ),
                                                        SizedBox(
                                                          width: 30,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    const Spacer(),

                  ],
                ),
              ),],
                
              ),



              floatingActionButton: FloatingActionButton(backgroundColor:Color.fromARGB(
                  255, 129, 4, 127),
                  onPressed: () {


    showDialog(
    context: context,
    builder: (BuildContextcontext) {
    return AlertDialog(
      title: Text("Add Notes", style: TextStyle(
        color: Colors.black,
      ),),
    backgroundColor: Colors.white,
    icon: Icon(Icons.info),
      content:  TextField(
        controller: controller,
        onSubmitted: (val) {
          notes.add(
            {
              'notes': val,

            },

          );
          Navigator.pop(context);
          controller.clear();
        },
        decoration: InputDecoration(
          labelText: "Add Notes ",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Color.fromARGB(100, 157, 29, 204)),
          ),
        ),
      ),


   );

                  },);},


                  child: const Icon(Icons.add,color: Colors.white,)


    ),


            );
          } else {
            return Scaffold(

              body: Center(
                child: Text(
                  "Loading....",
                  style: TextStyle(fontSize: 40,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }
        });
  }
}
