import 'package:flutter/material.dart';
import 'cv_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CvDisplay extends StatefulWidget {
  const CvDisplay({super.key});

  @override
  State<CvDisplay> createState() => _CvDisplayState();
}

class _CvDisplayState extends State<CvDisplay> {
  List<dynamic> cvDataList = [];
  Future<List<String>> getCvData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    if (jsonData != null) {
      final decodedData = json.decode(jsonData) as List<dynamic>;

      setState(() {
        cvDataList = decodedData.map((e) => CvFields.fromJson(e)).toList();
      });
    } else {
      cvDataList = [];
    }
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  @override
  void initState() {
    super.initState();
    getCvData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Details'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cvDataList.length,
              itemBuilder: (context, index) {
                //var cv = cvFieldsList[index]
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'First Name:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].firstName),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Middle Name:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].middleName),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Last Name:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].lastName),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Age:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].age),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'gender:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].gender),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Skills:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].skills.join(',')),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Work Experience Details:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: cvDataList[index].workExperience.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red)),
                              child: Column(
                                children: [
                                  Text(cvDataList[index]
                                      .workExperience[i]
                                      .jobTitle),
                                  Text(cvDataList[index]
                                      .workExperience[i]
                                      .summary),
                                  Text(cvDataList[index]
                                      .workExperience[i]
                                      .companyName),
                                  Text(cvDataList[index]
                                      .workExperience[i]
                                      .startDate),
                                  Text(cvDataList[index]
                                      .workExperience[i]
                                      .endDate)
                                ],
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Education Details:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: cvDataList[index].educationFields.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red)),
                              child: Column(
                                children: [
                                  Text(cvDataList[index]
                                      .educationFields[i]
                                      .organizationName),
                                  Text(cvDataList[index]
                                      .educationFields[i]
                                      .level),
                                  Text(cvDataList[index]
                                      .educationFields[i]
                                      .startDate),
                                  Text(cvDataList[index]
                                      .educationFields[i]
                                      .endDate)
                                ],
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text('Project Fields:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: cvDataList[index].projectFields.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red)),
                              child: Column(
                                children: [
                                  Text(cvDataList[index]
                                      .projectFields[i]
                                      .projectTitle),
                                  Text(cvDataList[index]
                                      .projectFields[i]
                                      .description),
                                  Text(cvDataList[index]
                                      .projectFields[i]
                                      .startDate),
                                  Text(cvDataList[index]
                                      .projectFields[i]
                                      .endDate),
                                  Text(cvDataList[index]
                                      .projectFields[i]
                                      .organizationName)
                                ],
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Languages:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].language.join(',')),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Interests:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].interest.join(',')),
                        ],
                      ),
                    ],
                  ),
                );
              })
        ]),
      ),
    );
  }
}
