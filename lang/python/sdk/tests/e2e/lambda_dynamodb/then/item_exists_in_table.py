"""Then: the item "EXISTS" in the table"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the item "EXISTS" in the table')
def item_exists_in_table(world):
    pytest.skip("Cannot observe Lambda item write result in lws")
