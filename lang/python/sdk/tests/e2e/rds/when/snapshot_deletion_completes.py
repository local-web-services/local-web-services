"""When: a "rds" "snapshot" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "rds" "snapshot" deletion completes')
def snapshot_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal RDS snapshot deletion completion in lws")
