"""Given: the "sns" "topic" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "topic" did not already exist')
def topic_not_already_exist():
    """No-op: fresh provider state has no topic named TEST_TOPIC."""
