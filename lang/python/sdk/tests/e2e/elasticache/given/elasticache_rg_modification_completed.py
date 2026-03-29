"""Given: a replication group modification has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a replication group modification has completed")
def elasticache_rg_modification_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache replication group modification as sequence setup in lws"  # noqa: E501
    )
