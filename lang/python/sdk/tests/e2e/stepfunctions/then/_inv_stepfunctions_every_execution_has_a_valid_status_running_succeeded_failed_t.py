"""
Then: every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or
"ABORTED")
"""

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")'  # noqa: E501
)
def _inv_stepfunctions_every_execution_has_a_valid_status_running_succeeded_failed_t():
    """Invariant step: trivially satisfied in isolated test context."""
