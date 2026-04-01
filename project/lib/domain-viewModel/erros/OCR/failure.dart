abstract class Failure {
  final String message;
  Failure(this.message);
}
class BeginOCRFailure extends Failure { BeginOCRFailure(String msg) : super(msg); }
class ReadFailure extends Failure { ReadFailure(String msg) : super(msg); }
class FailureFindValue extends Failure { FailureFindValue(String msg) : super(msg); }

class GetImageFailure extends Failure { GetImageFailure(String msg) : super(msg); }
class SharedFileFailure extends Failure { SharedFileFailure(String msg) : super(msg); }