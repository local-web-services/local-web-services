"""Given: the job is Succeeded"""

from __future__ import annotations

from pytest_bdd import given


@given("the job is Succeeded")
def job_is_succeeded():
    """No-op: jobs start in Succeeded state in the lws implementation."""
