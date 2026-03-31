"""Given: the "glacier" "job" output is not available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "job" output is not available')
def job_output_is_not_available_given():
    """No-op: fresh state has no job output."""
