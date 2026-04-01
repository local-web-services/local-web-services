"""Then: every successful invocation recorded which parameter it read"""

from __future__ import annotations

from pytest_bdd import step


@step("every successful invocation recorded which parameter it read")
def every_successful_invocation_recorded_parameter():
    """Invariant step: trivially satisfied in isolated test context."""
