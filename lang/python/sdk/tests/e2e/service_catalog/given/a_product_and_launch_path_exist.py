"""Given: a product and launch path exist"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_PRODUCT_ID


@given("a product and launch path exist")
@given('a "service catalog" "product" and "launch path" existed')
def a_product_and_launch_path_exist(world):
    """The default state is pre-seeded with a test product and launch path."""
    world["product_id"] = TEST_PRODUCT_ID
