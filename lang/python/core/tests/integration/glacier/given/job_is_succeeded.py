"""Given: the "glacier" "job" was "Succeeded" """

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "job" was "Succeeded"')
def job_is_succeeded():
    """No-op: jobs start in Succeeded state in the lws implementation."""
