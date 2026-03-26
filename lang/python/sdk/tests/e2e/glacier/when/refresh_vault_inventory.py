"""When: a vault inventory is refreshed"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a vault inventory is refreshed")
def refresh_vault_inventory(lws_session, world):
    pytest.skip("Cannot trigger internal vault inventory refresh in lws")
