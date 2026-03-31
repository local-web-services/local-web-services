"""When: a replica creation in a "elasticache" "replication group" completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a replica creation in a "elasticache" "replication group" completes')
def replica_creation_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache replica creation completion in lws")
