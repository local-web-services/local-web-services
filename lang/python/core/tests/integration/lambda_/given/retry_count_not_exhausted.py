"""Given: the "lambda" "function" async retry count had not been exhausted"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" async retry count had not been exhausted')
def retry_count_not_exhausted():
    """No-op: fresh state has no retry count."""
