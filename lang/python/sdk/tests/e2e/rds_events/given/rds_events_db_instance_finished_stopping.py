"""Given: the "DB" instance has finished stopping"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "DB" instance has finished stopping')
def rds_events_db_instance_finished_stopping():
    pytest.skip("Cannot trigger internal RDS DB instance stop completion in lws")
