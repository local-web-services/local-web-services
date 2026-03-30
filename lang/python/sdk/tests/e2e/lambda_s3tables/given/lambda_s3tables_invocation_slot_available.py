"""Given: an invocation slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("an invocation slot is available")
def lambda_s3tables_invocation_slot_available():
    """No-op: always room for invocations."""
