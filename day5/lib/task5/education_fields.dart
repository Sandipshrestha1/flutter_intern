import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'education_list.dart';

class EducationImplement extends StatefulWidget {
  const EducationImplement({super.key});

  @override
  State<EducationImplement> createState() => _EducationImplementState();
}

class _EducationImplementState extends State<EducationImplement> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController organizationName = TextEditingController();
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController achievements = TextEditingController();
  String _selectedLevel = "SEE";
  List<String> textFieldValues = [];

  void initState() {
    organizationName.text = "";
    startDateInput.text = "";
    endDateInput.text = "";
    achievements.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Education Form'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Center(
                    child: Text('Add Education Details'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 250.0,
                          child: TextFormField(
                            validator: (value) {
                              final regex = RegExp(r'[a-zA-Z]');
                              if (value == null || value.isEmpty) {
                                return "Cannot be empty";
                              } else if (value.length > 10) {
                                return 'Text must not exceed 10 characters';
                              } else if (!regex.hasMatch(value)) {
                                return 'Only alphabetic characters are allowed';
                              }
                              return null;
                            },
                            controller: organizationName,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Organization Name'),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Text('Level: '),
                            const SizedBox(
                              width: 10.0,
                            ),
                            DropdownButton(
                              value: _selectedLevel,
                              hint: const Text('Select Level'),
                              items: const <DropdownMenuItem<String>>[
                                DropdownMenuItem<String>(
                                  value: 'SEE',
                                  child: Text('SEE'),
                                ),
                                DropdownMenuItem<String>(
                                  value: '+2',
                                  child: Text('+2'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Bachelor',
                                  child: Text('Bachelor'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Master',
                                  child: Text('Master'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Phd',
                                  child: Text('Phd'),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedLevel = newValue!;
                                });
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Cannot be empty";
                              }
                              return null;
                            },
                            controller: startDateInput,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: "Start Date"),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);
                                setState(() {
                                  startDateInput.text = formattedDate;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Cannot be empty";
                              }
                              return null;
                            },
                            controller: endDateInput,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: "End Date"),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2022),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2024),
                              );
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);
                                setState(() {
                                  endDateInput.text = formattedDate;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: 250.0,
                          child: TextFormField(
                            controller: achievements,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Achievements'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          educationFieldsList.add(EducationFields(
                              organizationName: organizationName.text,
                              level: _selectedLevel,
                              startDate: startDateInput.text.toString(),
                              endDate: endDateInput.text.toString(),
                              achievements: achievements.text));

                          print('clicked');
                          Navigator.pop(context, educationFieldsList);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Data submitted')),
                          );
                        }
                      },
                      child: const Text('Submit'))
                ],
              ),
            ),
          ),
        ));
  }
}
