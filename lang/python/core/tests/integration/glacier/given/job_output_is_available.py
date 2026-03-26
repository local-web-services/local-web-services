"""Given: the job output is available"""

from __future__ import annotations

from pytest_bdd import given


@given("the job output is available")
def job_output_is_available():
    """No-op: output is available for any Succeeded job in lws."""
