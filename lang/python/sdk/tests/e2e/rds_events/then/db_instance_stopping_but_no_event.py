"""Then: the "rds" "DB instance" will be "STOPPING" but no event will be delivered"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "rds" "DB instance" will be "STOPPING" but no event will be delivered')
def db_instance_stopping_but_no_event():
    pytest.skip("Cannot observe internal RDS DB instance stopping state in lws")
