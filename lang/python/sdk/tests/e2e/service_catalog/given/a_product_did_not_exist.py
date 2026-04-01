"""Given: a product did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("a product did not exist")
def a_product_did_not_exist(world):
    """Set a non-existent product ID so ProvisionProduct fails."""
    world["product_id"] = "prod-missing"
