"""Given: the "DB" instance is "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "DB" instance is "AVAILABLE"')
def db_instance_is_available_given():
    pytest.skip("Cannot observe internal DB instance state transitions in lws")
