"""Then: the vault inventory is marked as fresh"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the vault inventory is marked as fresh")
def vault_inventory_marked_fresh_then():
    pytest.skip("Cannot observe internal vault inventory refresh in lws")
