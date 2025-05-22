import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_tienganh/models/notification_model.dart';

class NotificationController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<AppNotification>> getNotificationsStream(String userId) {
    if (userId.isEmpty) {
      print('Lỗi: userId rỗng trong getNotificationsStream');
      return Stream.value([]);
    }
    print('NotificationController: Truy vấn thông báo cho userId: $userId');
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          print(
            'NotificationController: Số thông báo tìm thấy: ${snapshot.docs.length}',
          );
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return AppNotification.fromMap({...data, 'notificationId': doc.id});
          }).toList();
        })
        .handleError((error) {
          print('NotificationController: Lỗi khi lấy thông báo: $error');
          return [];
        });
  }

  Future<void> createQuizCompletionNotification({
    required String userId,
    required String quizId,
    required int correctAnswersCount,
    required int totalQuestions,
    required String moduleId,
  }) async {
    try {
      print(
        'NotificationController: Tạo thông báo cho userId: $userId, quizId: $quizId',
      );
      final moduleSnapshot =
          await _firestore.collection('learning_modules').doc(moduleId).get();
      if (!moduleSnapshot.exists) {
        print('Lỗi: Học phần với ID $moduleId không tồn tại');
        return;
      }
      final moduleName =
          moduleSnapshot.data()?['moduleName'] ?? 'Chưa có tên module';
      final notificationId = DateTime.now().millisecondsSinceEpoch.toString();
      await _firestore.collection('notifications').doc(notificationId).set({
        'notificationId': notificationId,
        'userId': userId,
        'mainText': 'Bạn đã hoàn thành bài kiểm tra $moduleName',
        'subText':
            'Bạn trả lời đúng $correctAnswersCount câu trên tổng số $totalQuestions. Tiếp tục cố gắng nhé!',
        'svgPath': 'assets/img/Frame107.svg',
        'createdAt': FieldValue.serverTimestamp(),
      });
      print(
        'NotificationController: Thông báo đã được tạo với notificationId: $notificationId',
      );
    } catch (e) {
      print('NotificationController: Lỗi khi tạo thông báo: $e');
    }
  }

  Future<void> createModuleCreationNotification({
    required String userId,
    required String moduleId,
    required String moduleName,
  }) async {
    try {
      print(
        'NotificationController: Tạo thông báo tạo học phần cho userId: $userId, moduleId: $moduleId',
      );
      final notificationId = DateTime.now().millisecondsSinceEpoch.toString();
      await _firestore.collection('notifications').doc(notificationId).set({
        'notificationId': notificationId,
        'userId': userId,
        'mainText': 'Bạn đã tạo học phần $moduleName',
        'subText': 'Học phần mới đã được thêm vào danh sách của bạn.',
        'svgPath': 'assets/img/icon_fire.svg', // Thay bằng đường dẫn phù hợp
        'createdAt': FieldValue.serverTimestamp(),
      });
      print(
        'NotificationController: Thông báo tạo học phần đã được tạo với notificationId: $notificationId',
      );
    } catch (e) {
      print('NotificationController: Lỗi khi tạo thông báo tạo học phần: $e');
    }
  }

  Future<void> createModuleEditNotification({
    required String userId,
    required String moduleId,
    required String moduleName,
  }) async {
    try {
      print(
        'NotificationController: Tạo thông báo chỉnh sửa học phần cho userId: $userId, moduleId: $moduleId',
      );
      final notificationId = DateTime.now().millisecondsSinceEpoch.toString();
      await _firestore.collection('notifications').doc(notificationId).set({
        'notificationId': notificationId,
        'userId': userId,
        'mainText': 'Bạn đã chỉnh sửa học phần $moduleName',
        'subText': 'Học phần của bạn đã được cập nhật thành công.',
        'svgPath': 'assets/img/icon_fire.svg', // Thay bằng đường dẫn phù hợp
        'createdAt': FieldValue.serverTimestamp(),
      });
      print(
        'NotificationController: Thông báo chỉnh sửa học phần đã được tạo với notificationId: $notificationId',
      );
    } catch (e) {
      print(
        'NotificationController: Lỗi khi tạo thông báo chỉnh sửa học phần: $e',
      );
    }
  }
}
