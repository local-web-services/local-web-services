"""When: an "elasticache" "cluster" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "elasticache" "cluster" modification completes')
def cluster_modification_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache cluster modification completion in lws")
