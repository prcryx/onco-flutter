import 'package:onco_connect/common/exceptions/base_app_exception.dart';

class DataFetchException extends AppException {
  DataFetchException(cause, StackTrace? stackTrace)
      : super(
            codeInt: 403,
            codeString: "Fetch Failed",
            message: cause.toString(),
            trace: stackTrace);
}

class DataNotExistsException extends AppException {
  DataNotExistsException()
      : super(
          codeInt: 403,
          codeString: "Data Not Exists",
          message: "Please try again after sometime!",
        );
}

class NoAppMetaDataException extends AppException {
  NoAppMetaDataException()
      : super(
          codeInt: 400,
          codeString: "No Metadata",
          message: "No metadata available",
        );
}
class NoUserMetaDataException extends AppException {
  NoUserMetaDataException()
      : super(
          codeInt: 400,
          codeString: "No User Metadata",
          message: "No user metadata available",
        );
}

class DataStoreException extends AppException {
  DataStoreException(StackTrace? stackTrace)
      : super(
            codeInt: 400,
            codeString: "Failed",
            message: "Data store failed",
            trace: stackTrace);
}
