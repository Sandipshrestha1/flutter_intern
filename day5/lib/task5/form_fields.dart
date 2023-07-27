import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'work_experience_fields.dart';
import 'work_list.dart';
import 'education_fields.dart';
import 'education_list.dart';
import 'project_fields.dart';
import 'project_list.dart';
import 'cv_list.dart';
import 'cv_display.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TextFieldImplement extends StatefulWidget {
  const TextFieldImplement({super.key});

  @override
  State<TextFieldImplement> createState() => _TextFieldImplementState();
}

class _TextFieldImplementState extends State<TextFieldImplement> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController age = TextEditingController();
  String gender = '';
  List<String> skills = [
    'Python',
    'Java',
    'Flutter',
    'Php',
    'Designing',
    'R',
    'React',
    '.Net',
    'Hacking',
    'Penetrasting',
  ];
  List<String> selectedSkills = [];
  List<String> selectedLanguages = [];
  List<String> selectedInterests = [];
  ValueNotifier<bool> _switchValue = ValueNotifier<bool>(false);
  List<Map<String, dynamic>> languageList = [
    {
      "name": "English",
      "isChecked": false,
    },
    {
      "name": "Nepali",
      "isChecked": false,
    },
    {
      "name": "Hindi",
      "isChecked": false,
    },
  ];
  List<Map<String, dynamic>> interestAreaList = [
    {
      "name": "Android Application",
      "isChecked": false,
    },
    {
      "name": "ios Application",
      "isChecked": false,
    },
    {
      "name": "QA Engineer",
      "isChecked": false,
    },
    {
      "name": "iit device",
      "isChecked": false,
    },
    {
      "name": "DevOps",
      "isChecked": false,
    },
    {
      "name": "Hacking",
      "isChecked": false,
    },
  ];
  void _toggleSkillSelection(String skill) {
    setState(() {
      if (selectedSkills.contains(skill)) {
        selectedSkills.remove(skill);
      } else {
        selectedSkills.add(skill);
      }
    });
  }

  void _toggleLanguageSelection(String language) {
    setState(() {
      if (selectedLanguages.contains(language)) {
        selectedLanguages.remove(language);
      } else {
        selectedLanguages.add(language);
      }
    });
  }

  void _toggleInterestSelection(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedLanguages.add(interest);
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.reset();
    }
  }

  Future<void> saveCvData() async {
    cvFieldsList.add(
      CvFields(
        firstName: firstName.text,
        lastName: lastName.text,
        middleName: middleName.text,
        gender: gender,
        age: age.text,
        skills: selectedSkills,
        workExperience: workFieldsList,
        educationFields: educationFieldsList,
        projectFields: projectFieldsList,
        language: selectedLanguages,
        interest: selectedInterests,
      ),
    );

    //sending  data to json list
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> jsonDataList =
        cvFieldsList.map((cv) => cv.toJson()).toList();

    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('dataList', jsonData);
  }

  @override
  void initState() {
    firstName.text = "";
    middleName.text = "";
    lastName.text = "";
    age.text = "";
    workFieldsList = workFieldsList;
    projectFieldsList = projectFieldsList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.green,
      )),
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              width: 350.0,
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
                controller: firstName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'First Name'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 350.0,
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
                controller: middleName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Middle Name'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 350.0,
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
                controller: lastName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Last Name'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 350.0,
              child: TextFormField(
                validator: (value) {
                  final regex = RegExp(
                      r'^\d+$'); // Match only digits using the correct regular expression pattern.
                  if (value == null || value.isEmpty) {
                    return "Cannot be empty";
                  } else if (value.length > 3) {
                    return 'Age must not exceed 3 characters'; // The error message should mention 3 characters, not 5.
                  } else if (!regex.hasMatch(value)) {
                    return 'Only digits are allowed';
                  }
                  return null;
                },
                controller: age,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Age'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Gender:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Radio<String>(
                  value: 'male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value ?? '';
                    });
                  },
                ),
                const Text('Male'),
                Radio<String>(
                  value: 'female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value ?? '';
                    });
                  },
                ),
                const Text('Female'),
                Radio<String>(
                  value: 'other',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value ?? '';
                    });
                  },
                ),
                const Text('Other'),
              ],
            ),
            const Text(
              'Skills:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _skillsOption(),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                const Text(
                  'Work Experience:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 100.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const workExperienceImplement()),
                    );
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Wrap(
              runSpacing: 9.0,
              children: _workFieldlayout(),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                const Text(
                  'Education:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 143.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EducationImplement(),
                        ),
                      );
                    },
                    child: const Text('Add')),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Wrap(
              runSpacing: 9.0,
              children: _educationListUi(),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                const Text('Other Projects',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 120.0,
                ),
                ValueListenableBuilder(
                    valueListenable: _switchValue,
                    builder: (context, value, child) {
                      return Switch(
                        value: value,
                        onChanged: (newValue) {
                          setState(() {
                            _switchValue.value = newValue;
                          });
                          if (newValue) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProjectImplement()),
                            );
                          }
                        },
                      );
                    }),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Wrap(
              runSpacing: 9.0,
              children: _projectFieldsUi(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Languages: '),
            const SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              child: Row(
                  children: languageList.map((language) {
                return Row(
                  children: [
                    Checkbox(
                        value: language['isChecked'],
                        onChanged: (bool? value) {
                          setState(() {
                            language["isChecked"] = value;

                            _toggleLanguageSelection(language["name"]);
                          });
                        }),
                    Text(language["name"]),
                  ],
                );
              }).toList()),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text('Interest Areas'),
            const SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: interestAreaList.map((interest) {
                return Row(
                  children: [
                    Checkbox(
                        value: interest['isChecked'],
                        onChanged: (bool? value) {
                          setState(() {
                            interest["isChecked"] = value;
                            _toggleInterestSelection(interest["name"]);
                          });
                        }),
                    Text(interest["name"]),
                  ],
                );
              }).toList()),
              //physics: AlwaysScrollableScrollPhysics(),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveCvData();
                    _submitForm(); // Reset the form
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data submitted')),
                    );

// Clear text fields after successful submission
                    firstName.clear();
                    middleName.clear();
                    lastName.clear();
                    age.clear();
                    gender = '';
                    selectedSkills.clear();
                    selectedLanguages.clear();
                    selectedInterests.clear();
                    _switchValue.value = false;
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CvDisplay()),
                    );
                  },
                  child: const Text('View CV')),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _skillsOption() {
    return skills.map((skill) {
      final isSelected = selectedSkills.contains(skill);
      return Chip(
        label: Text(skill),
        backgroundColor: isSelected ? Colors.green : Colors.blue,
        labelStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onDeleted: () {
          _toggleSkillSelection(skill);
        },
        deleteIconColor: Colors.white,
      );
    }).toList();
  }

  List<Widget> _workFieldlayout() {
    return workFieldsList.map(
      (w) {
        return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Job Title: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(w.jobTitle)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Summary: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(w.summary)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Company Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(w.companyName)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Start Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(w.startDate)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'End Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(w.endDate)
                  ],
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        workFieldsList.remove(w);
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ));
      },
    ).toList();
  }

  List<Widget> _educationListUi() {
    return educationFieldsList.map(
      (e) {
        return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Organization Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.organizationName)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Level: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.level)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'start date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.startDate)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'End Datee: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.endDate)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Achievements: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.achievements)
                  ],
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        educationFieldsList.remove(e);
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ));
      },
    ).toList();
  }

  List<Widget> _projectFieldsUi() {
    return projectFieldsList.map(
      (e) {
        return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Project Title: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.projectTitle)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Description: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.description)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Start Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.startDate)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'End Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.endDate)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Organization Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.organizationName)
                  ],
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        projectFieldsList.remove(e);
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ));
      },
    ).toList();
  }
}
