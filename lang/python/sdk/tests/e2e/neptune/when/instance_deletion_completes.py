"""When: a database instance deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database instance deletion completes")
def instance_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune instance deletion completion in lws")
