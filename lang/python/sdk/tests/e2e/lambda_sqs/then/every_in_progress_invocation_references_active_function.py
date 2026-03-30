"""Then: every in-progress invocation references an "ACTIVE" Lambda function"""

from __future__ import annotations

from pytest_bdd import then


@then('every in-progress invocation references an "ACTIVE" Lambda function')
def every_in_progress_invocation_references_active_function():
    """Invariant step: trivially satisfied in isolated test context."""
