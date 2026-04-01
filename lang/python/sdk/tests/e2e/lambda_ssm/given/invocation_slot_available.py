"""Given: a "lambda" "invocation" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('a "lambda" "invocation" slot is available')
def invocation_slot_available():
    """No-op: always room for invocations."""
