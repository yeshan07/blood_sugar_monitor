// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Monitor App",
      theme: ThemeData(
        primaryColor: Colors.brown[100], 
      ),
      home: const BloodSugarTestPage(),
    );
  }
}

class BloodSugarTestPage extends StatefulWidget {
  const BloodSugarTestPage({Key? key}) : super(key: key);

  @override
 
  
  _BloodSugarTestPageState createState() => _BloodSugarTestPageState();
}

class _BloodSugarTestPageState extends State<BloodSugarTestPage> {
  TextEditingController beforeController = TextEditingController();
  TextEditingController afterController = TextEditingController();
  String? selectedGroup;

  @override
  void dispose() {
    
    beforeController.dispose();
    afterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.brown[100],
        shadowColor: Colors.yellow,
        title: const Text(
          "Test Your Blood Sugar",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "It's time to add your first measurement.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 1,
              ),
              Center(
                child: Image.asset(
                  "assets/img 2.jpg",
                  height: 150,
                  scale: 5,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your before blood glucose value",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: beforeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter before blood glucose value",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your after blood glucose value",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: afterController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter after blood glucose value",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Select group of people",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedGroup,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGroup = newValue;
                  });
                },
                items: <String>[
                  'Adults',
                  'Children',
                  '65 or older',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage(
                        beforeValue: double.parse(beforeController.text),
                        afterValue: double.parse(afterController.text),
                        selectedGroup: selectedGroup ?? 'Unknown',
                      )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50), 
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Second Page
class SecondPage extends StatelessWidget {
  final double beforeValue;
  final double afterValue;
  final String selectedGroup;

  const SecondPage({Key? key, required this.beforeValue, required this.afterValue, required this.selectedGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double result = afterValue - beforeValue;
    String resultText = result < 0 ? "Invalid Data" : "$result mg/dl";
    String condition = getCondition(result);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[100],
        title: const Text('Details'),
        actions: [
          IconButton(
            onPressed: () {
              
              // saving icon
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Details Saved')),
              );
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Date & Time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Text(
                          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Text(
                        '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Blood Glucose',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  resultText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Group of People',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selectedGroup,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Condition',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  condition,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
                  "assets/img 1.jpg",
                  height: 120,
                ),
        ],
      ),
    );
  }

  String getCondition(double glucoseLevel) {
    if (glucoseLevel < 70) {
      return 'Low';
    } else if (glucoseLevel >= 70 && glucoseLevel <= 100) {
      return 'Normal';
    } else {
      return 'High';
    }
  }
  
  void _selectTime(BuildContext context) {}
  
  void _selectDate(BuildContext context) {}
}
