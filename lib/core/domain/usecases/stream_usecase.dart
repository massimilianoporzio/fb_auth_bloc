abstract class StreamUseCase<T, Parameters> {
  Stream<T?> call(Parameters parameters);
}
