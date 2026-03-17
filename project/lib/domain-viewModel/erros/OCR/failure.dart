abstract class Failure {
  final String message;
  Failure(this.message);
}
class BeginOCRFailure extends Failure { BeginOCRFailure(String msg) : super(msg); }
class ReadFailure extends Failure { ReadFailure(String msg) : super(msg); }


class GetImageFailure extends Failure { GetImageFailure(String msg) : super(msg); }