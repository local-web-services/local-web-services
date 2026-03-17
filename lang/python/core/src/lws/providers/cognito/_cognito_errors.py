"""Cognito exception classes."""

from __future__ import annotations


class CognitoError(Exception):
    """Base Cognito exception with an error code."""

    def __init__(self, code: str, message: str) -> None:
        super().__init__(message)
        self.code = code


class UsernameExistsException(CognitoError):
    """Raised when a username is already taken."""

    def __init__(self, username: str) -> None:
        super().__init__("UsernameExistsException", f"User already exists: {username}")


class InvalidPasswordException(CognitoError):
    """Raised when a password does not meet policy requirements."""

    def __init__(self, message: str) -> None:
        super().__init__("InvalidPasswordException", message)


class InvalidParameterException(CognitoError):
    """Raised when a required attribute is missing."""

    def __init__(self, message: str) -> None:
        super().__init__("InvalidParameterException", message)


class NotAuthorizedException(CognitoError):
    """Raised when credentials are invalid."""

    def __init__(self, message: str = "Incorrect username or password.") -> None:
        super().__init__("NotAuthorizedException", message)


class UserNotConfirmedException(CognitoError):
    """Raised when a user has not confirmed their account."""

    def __init__(self) -> None:
        super().__init__("UserNotConfirmedException", "User is not confirmed.")


class UserNotFoundException(CognitoError):
    """Raised when a user is not found."""

    def __init__(self, username: str) -> None:
        super().__init__("UserNotFoundException", f"User does not exist: {username}")


class ExpiredCodeException(CognitoError):
    """Raised when a confirmation code has expired."""

    def __init__(self) -> None:
        super().__init__("ExpiredCodeException", "Confirmation code has expired.")


class CodeMismatchException(CognitoError):
    """Raised when a confirmation code does not match."""

    def __init__(self) -> None:
        super().__init__("CodeMismatchException", "Invalid verification code provided.")
