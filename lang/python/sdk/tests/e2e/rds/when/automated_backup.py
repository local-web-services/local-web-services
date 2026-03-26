"""When: an automated backup runs on an available instance"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an automated backup runs on an available instance")
def automated_backup(lws_session, world):
    pytest.skip("Cannot trigger internal RDS automated backup in lws")
