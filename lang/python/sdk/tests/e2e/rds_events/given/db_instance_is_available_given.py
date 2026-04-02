"""Given: the "rds" "DB instance" was "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "rds" "DB instance" was "AVAILABLE"')
def db_instance_is_available_given():
    pytest.skip("Cannot observe internal DB instance state transitions in lws")
