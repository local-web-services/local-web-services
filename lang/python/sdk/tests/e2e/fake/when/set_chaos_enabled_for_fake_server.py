"""When: chaos is enabled or disabled for a fake server"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("chaos is enabled or disabled for a fake server")
def set_chaos_enabled_for_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
