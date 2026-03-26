"""Then: the "DB" instance is "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "DB" instance is "STOPPED"')
def db_instance_is_stopped_then():
    pytest.skip("Cannot observe internal RDS DB instance stopped state in lws")
