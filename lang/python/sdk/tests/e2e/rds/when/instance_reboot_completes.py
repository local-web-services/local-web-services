"""When: a database instance reboot completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database instance reboot completes")
def instance_reboot_completes(lws_session, world):
    pytest.skip("Cannot trigger internal RDS instance reboot completion in lws")
