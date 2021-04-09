class RequiredInputNotEnteredException extends _RequiredInputNotEnteredException
{
  RequiredInputNotEnteredException()
    : super("Required input must be entered");
}

class _RequiredInputNotEnteredException implements Exception
{
  _RequiredInputNotEnteredException(String message);
}
