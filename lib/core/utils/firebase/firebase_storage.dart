import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<Either<List<Reference>, String>> fetchDetectedDocument(
    String folderName) async {
  List<Reference> classRefs = [];
  try {
    final storageRef =
        FirebaseStorage.instanceFor(bucket: 'gs://ai-tourism-f8513.appspot.com')
            .ref();
    await storageRef
        .child(folderName)
        .listAll()
        .then((files) => classRefs = files.items);
    return Left(classRefs);
  } catch (e) {
    return Right('Error Occurred: $e');
  }
}
