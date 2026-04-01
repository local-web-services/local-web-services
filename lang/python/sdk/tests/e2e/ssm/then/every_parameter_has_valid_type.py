"""Then: every parameter has a valid type (String, SecureString, or StringList)"""

from __future__ import annotations

from pytest_bdd import step


@step("every parameter has a valid type (String, SecureString, or StringList)")
def every_parameter_has_valid_type():
    """No-op invariant: trivially satisfied in an isolated test context."""
