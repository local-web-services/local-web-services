"""Then: the "rds" "DB instance" will be "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "rds" "DB instance" will be "STOPPED"')
def db_instance_is_stopped_then():
    pytest.skip("Cannot observe internal RDS DB instance stopped state in lws")
