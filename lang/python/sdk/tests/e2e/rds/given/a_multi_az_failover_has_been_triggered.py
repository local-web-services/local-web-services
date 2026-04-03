"""Given: a multi-"AZ" failover is triggered on a "rds" "instance" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DB


@given('a multi-"AZ" failover is triggered on a "rds" "instance"')
def a_multi_az_failover_has_been_triggered(lws_session):
    lws_session.inject_state("rds", "instance", TEST_DB, "failing_over")
