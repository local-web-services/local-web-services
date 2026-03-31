"""Then: the item will exist in the "dynamodb" "table" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the item will exist in the "dynamodb" "table"')
def item_exists_in_table(world):
    pytest.skip("Cannot observe Lambda item write result in lws")
