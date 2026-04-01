"""Given: the event source mapping did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the event source mapping did not exist")
def dynamodb_lambda_esm_does_not_exist(world):
    """No-op: fresh state has no event source mappings."""
    world["esm_exists"] = False
