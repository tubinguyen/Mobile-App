// import 'package:mongo_dart/mongo_dart.dart';
// import 'constant.dart'; // chứa URL, DB name, Collection name

// class MongoDatabase {
//   static late Db db;
//   static late DbCollection userCollection;

//   static Future<void> connect() async {
//     db = await Db.create(MONGO_CONN_URL);
//     await db.open();
//     userCollection = db.collection(MONGO_COLLECTION_USERS); // VD: "users"
//   }

//   static Future<void> close() async {
//     await db.close();
//   }
// }
