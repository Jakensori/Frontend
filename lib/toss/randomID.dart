// import 'package:uuid/uuid.dart';

// String generateRandomSlugCode({int length = 15}) {
//   if (length < 1 || length > 32) {
//     throw ArgumentError('Length should be between 1 and 32.');
//   }

//   var randomBytes = Uuid().v4().toBytes();
//   var base64Encoded = base64.encode(randomBytes).trim();
//   var urlSafeEncoded = base64UrlEncode(base64Encoded.codeUnits);

//   return urlSafeEncoded.substring(0, length);
// }
