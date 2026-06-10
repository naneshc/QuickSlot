abstract class Result<S, F> {
  const Result();

  R fold<R>(
    R Function(S success) onSuccess,
    R Function(F failure) onFailure,
  );
}

class Success<S, F> extends Result<S, F> {
  final S value;
  const Success(this.value);

  @override
  R fold<R>(R Function(S success) onSuccess, R Function(F failure) onFailure) {
    return onSuccess(value);
  }
}

class FailureResult<S, F> extends Result<S, F> {
  final F value;
  const FailureResult(this.value);

  @override
  R fold<R>(R Function(S success) onSuccess, R Function(F failure) onFailure) {
    return onFailure(value);
  }
}
