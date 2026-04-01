"""When: an "elasticache" "cluster" restore from "elasticache" "snapshot" completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "elasticache" "cluster" restore from "elasticache" "snapshot" completes')
def cluster_restore_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache cluster restore completion in lws")
