"""Given: the "lambda" "function" had unreserved concurrency"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" had unreserved concurrency')
def function_has_unreserved_concurrency():
    """No-op: functions without explicit concurrency use unreserved pool."""
