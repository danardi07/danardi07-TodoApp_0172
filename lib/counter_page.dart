import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();

  List<String> listTugas = [];
  List<bool> listStatus = []; 

  void addData() {
    setState(() {
      if (_taskController.text.isNotEmpty) {
        listTugas.add(_taskController.text);
        listStatus.add(false);
        _taskController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('./assets/images/robben.jpg'),
                  ),
                  SizedBox(width: 10),
                  Text('Patrick Star'),
                ],
              ),
              Form(
                key: _key,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          label: Text('Task'),
                          hintText: 'Masukkan tugas yang ingin dilakukan',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Task tidak boleh kosong';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          addData();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listTugas.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(10),
                      ),
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(listTugas[index]),
                                Text(
                                  listStatus[index] ? 'Done' : 'Not Done',
                                  style: TextStyle(
                                    color: listStatus[index] ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Checkbox(
                              value: listStatus[index],
                              onChanged: (value) {
                                setState(() {
                                  listStatus[index] = value!;
                                });
                              },
                            ),
                          ],
                        ),
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
  }
