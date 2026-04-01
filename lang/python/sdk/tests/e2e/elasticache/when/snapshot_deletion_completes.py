"""When: an "elasticache" "snapshot" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "elasticache" "snapshot" deletion completes')
def snapshot_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache snapshot deletion completion in lws")
