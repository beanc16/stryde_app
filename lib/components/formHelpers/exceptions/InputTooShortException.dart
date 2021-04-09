class InputTooShortException extends _InputTooShortException
{
  InputTooShortException({
    required int inputMaxLength
  })
    : super("Input must be less than $inputMaxLength characters");
}

class _InputTooShortException implements Exception
{
  _InputTooShortException(String message);
}
