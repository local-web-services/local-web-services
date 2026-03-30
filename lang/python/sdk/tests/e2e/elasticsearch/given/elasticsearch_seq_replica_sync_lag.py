"""Given: a replica sync lag event has occurred on an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a replica sync lag event has occurred on an active domain")
def elasticsearch_seq_replica_sync_lag():
    pytest.skip("Cannot simulate replica sync lag in lws")
