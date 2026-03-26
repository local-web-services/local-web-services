"""Given: the retry count has not been exhausted"""

from __future__ import annotations

from pytest_bdd import given


@given("the retry count has not been exhausted")
def retry_count_not_exhausted():
    """No-op: fresh state has no retry count."""
