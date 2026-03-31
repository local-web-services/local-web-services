"""Given: a "rds" "instance" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "instance" finishes creating')
def a_database_instance_has_finished_creating():
    pytest.skip("Cannot trigger internal RDS instance creation completion in lws")
