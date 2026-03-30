"""Given: the event source mapping does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the event source mapping does not already exist")
def dynamodb_lambda_esm_not_already_exist():
    """No-op: fresh state has no event source mappings."""
