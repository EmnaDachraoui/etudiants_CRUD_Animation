import 'package:flutter/material.dart';
import 'package:td/screens/home_screen.dart';
import 'package:td/service/student_service.dart';
import '../entity/student_model.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  StudentService studentService = StudentService();

  addStd() async {
    StudentModel? addedStudent =
        await studentService.addStudent(name.text, email.text, selectedClass!);

    if (addedStudent != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Valid")));

      if (!mounted) return;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      // Navigator.pop(context);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error adding student")));
    }
  }

  List<String> classes = [
    "DSI 31",
    "DSI 32",
    "DSI 33",
    "DSI 34",
    "DSI 35",
    "DSI 36"
  ];
  String? selectedClass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add student")),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(controller: name),
            TextFormField(controller: email),
            DropdownButtonFormField<String>(
              value: selectedClass,
              items: classes.map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedClass = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Select Class'),
            ),
            ElevatedButton(onPressed: () => addStd(), child: const Text("add"))
          ],
        ),
      ),
    );
  }
} 

/* import 'package:flutter/material.dart';
import 'package:td/screens/home_screen.dart';
import 'package:td/service/student_service.dart';
import '../entity/student_model.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController dateOfBirthController =
      TextEditingController(); // Contrôleur pour la date de naissance
  StudentService studentService = StudentService();

  addStd() async {
    DateTime? dateOfBirth =
        DateTime.tryParse(dateOfBirthController.text); // Convertir en DateTime
    StudentModel? addedStudent = await studentService.addStudent(name.text,
        email.text, selectedClass!, dateOfBirth); // Inclure dateOfBirth

    if (addedStudent != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Valid")));

      if (!mounted) return;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      // Navigator.pop(context);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error adding student")));
    }
  }

  List<String> classes = [
    "DSI 31",
    "DSI 32",
    "DSI 33",
    "DSI 34",
    "DSI 35",
    "DSI 36"
  ];
  String? selectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add student")),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
                controller: name,
                decoration: InputDecoration(labelText: 'Name')),
            TextFormField(
                controller: email,
                decoration: InputDecoration(labelText: 'Email')),
            TextFormField(
              controller: dateOfBirthController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      dateOfBirthController.text =
                          pickedDate.toIso8601String(); // Format ISO 8601
                    }
                  },
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedClass,
              items: classes.map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedClass = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Select Class'),
            ),
            ElevatedButton(onPressed: () => addStd(), child: const Text("add"))
          ],
        ),
      ),
    );
  }
}
 */