import 'package:dio/dio.dart';
import '../entity/student_model.dart';
import 'package:logger/logger.dart';

class StudentService {
  static const String endpoint = "http://192.168.1.25:3000/students";
  final Dio _dio = Dio();
  var logger = Logger();

  Future<List<StudentModel>> getStudents() async {
    try {
      Response response = await _dio.get(endpoint);
      if (response.statusCode == 200) {
        return List.generate(
          response.data.length,
          (index) => StudentModel.fromJson(response.data[index]),
        );
      }
    } catch (error) {
      logger.e("Error fetching students: $error");
    }
    return [];
  }

  Future<StudentModel?> getStudentById(int id) async {
    try {
      Response response = await _dio.get("$endpoint/$id");
      if (response.statusCode == 200) {
        return StudentModel.fromJson(response.data);
      }
    } catch (error) {
      logger.e("Error fetching student by ID: $error");
    }
    return null;
  }

  Future<bool> editStudent(
      int id, String name, String email, String classe) async {
    try {
      StudentModel updatedStudent =
          StudentModel(id: id, name: name, email: email, classe: classe);
      Response response =
          await _dio.put("$endpoint/$id", data: updatedStudent.toJson());
      return response.statusCode == 200;
    } catch (error) {
      logger.e("Error editing student: $error");
      return false;
    }
  }

  Future<bool> deleteStudent(int id) async {
    try {
      Response response = await _dio.delete("$endpoint/$id");
      return response.statusCode == 200;
    } catch (error) {
      logger.e("Error deleting student: $error");
      return false;
    }
  }

  Future<StudentModel?> addStudent(
      String name, String email, String classe) async {
    try {
      StudentModel addedStudent =
          StudentModel(name: name, email: email, classe: classe);
      Response response =
          await _dio.post(endpoint, data: addedStudent.toJson());
      if (response.statusCode == 201) {
        StudentModel newStudent = StudentModel.fromJson(response.data);
        return newStudent;
      } else {
        return null;
      }
    } catch (error) {
      logger.e("Error adding student: $error");
      return null;
    }
  }
}
