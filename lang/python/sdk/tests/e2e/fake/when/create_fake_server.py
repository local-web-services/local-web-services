"""When: a fake server is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a fake server is created")
def create_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
