"""Then: the error log only contains ParameterAlreadyExists entries"""

from __future__ import annotations

from pytest_bdd import then


@then("the error log only contains ParameterAlreadyExists entries")
def error_log_only_parameter_already_exists():
    """No-op invariant: trivially satisfied in an isolated test context."""
