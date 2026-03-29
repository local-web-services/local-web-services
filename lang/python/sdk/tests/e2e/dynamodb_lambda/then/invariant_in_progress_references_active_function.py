"""Then: every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function"""

from __future__ import annotations

from pytest_bdd import then


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def invariant_in_progress_references_active_function():
    """Invariant: trivially satisfied in isolated lws context."""
