"""When: a Multi-"AZ" failover begins on the "DB" instance"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a Multi-"AZ" failover begins on the "DB" instance')
def multi_az_failover_begins(lws_session, world):
    pytest.skip("Cannot trigger a Multi-AZ failover on an RDS DB instance in lws")
