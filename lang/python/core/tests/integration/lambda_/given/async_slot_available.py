"""Given: a "lambda" "async" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('a "lambda" "async" "slot" was "available"')
def async_slot_available():
    """No-op: async slots are available by default."""
