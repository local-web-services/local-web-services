"""When: a "neptune" "instance" reboot completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "neptune" "instance" reboot completes')
def finish_reboot_db_instance(client: TestClient, world: dict):
    pytest.skip("RebootDBInstance is not yet implemented in lws.")
