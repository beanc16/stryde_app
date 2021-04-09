class InputTooLongException extends _InputTooLongException
{
  InputTooLongException({
    required int inputMinLength
  })
    : super("Input must be longer than $inputMinLength characters");
}

class _InputTooLongException implements Exception
{
  _InputTooLongException(String message);
}
