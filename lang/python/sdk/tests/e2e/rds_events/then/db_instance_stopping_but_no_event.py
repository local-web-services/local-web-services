"""Then: the "DB" instance is "STOPPING" but no event is delivered"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "DB" instance is "STOPPING" but no event is delivered')
def db_instance_stopping_but_no_event():
    pytest.skip("Cannot observe internal RDS DB instance stopping state in lws")
