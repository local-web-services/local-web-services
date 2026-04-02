"""Then: the "rds" "DB instance" will be "STOPPING" and the "eventbridge" "event" will be "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "rds" "DB instance" will be "STOPPING" and the "eventbridge" "event" will be "DELIVERED"'
)
def db_instance_stopping_and_event_delivered():
    pytest.skip("Cannot trigger internal RDS DB instance stop event delivery in lws")
