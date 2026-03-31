"""Given: a "rds" "instance" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "instance" deletion completes')
def a_database_instance_deletion_has_completed():
    pytest.skip("Cannot trigger internal RDS instance deletion completion in lws")
