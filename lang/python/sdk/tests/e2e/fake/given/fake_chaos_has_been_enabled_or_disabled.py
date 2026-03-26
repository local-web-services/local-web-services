"""Given: chaos has been enabled or disabled for a fake server"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("chaos has been enabled or disabled for a fake server")
def fake_chaos_has_been_enabled_or_disabled():
    pytest.skip("Fake service is not yet available in LwsSession")
