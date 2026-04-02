"""Given: the "rds" "DB instance" was not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "rds" "DB instance" was not "AVAILABLE"')
def db_instance_is_not_available_given():
    pytest.skip("Cannot control DB instance availability state in lws")
