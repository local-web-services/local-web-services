"""Then: the "DB" instance is "STOPPING" and the event is "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "DB" instance is "STOPPING" and the event is "DELIVERED"')
def db_instance_stopping_and_event_delivered():
    pytest.skip("Cannot trigger internal RDS DB instance stop event delivery in lws")
