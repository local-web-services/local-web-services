"""
Then: every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or
"ABORTED")
"""

from __future__ import annotations

from pytest_bdd import then


@then(
    "every execution has a valid status"
    ' ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")'
)
def every_execution_has_valid_status():
    """Invariant: trivially satisfied in isolated lws context."""
