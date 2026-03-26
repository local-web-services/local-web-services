"""When: the status of a fake server is retrieved"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the status of a fake server is retrieved")
def get_status_of_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
