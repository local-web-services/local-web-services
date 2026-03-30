"""When: a database instance restore from snapshot completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database instance restore from snapshot completes")
def instance_restore_completes(lws_session, world):
    pytest.skip("Cannot trigger internal RDS instance restore completion in lws")
