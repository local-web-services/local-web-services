"""Given: the "DB" instance is not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "DB" instance is not "AVAILABLE"')
def db_instance_is_not_available_given():
    pytest.skip("lws does not support non-AVAILABLE RDS DB instance lifecycle states")
