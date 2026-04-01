"""Given: the cloudformation stack did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the cloudformation stack did not exist")
def stack_did_not_exist():
    """No-op: lws_session fixture provides a fresh state for each scenario."""
