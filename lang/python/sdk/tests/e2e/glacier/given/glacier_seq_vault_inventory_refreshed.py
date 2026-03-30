"""Given: a vault inventory has been refreshed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a vault inventory has been refreshed")
def glacier_seq_vault_inventory_refreshed():
    pytest.skip("Cannot trigger internal vault inventory refresh in lws")
