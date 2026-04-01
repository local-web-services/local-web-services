"""Given: a "rds" "instance" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "instance" modification completes')
def a_database_instance_modification_has_completed():
    pytest.skip("Cannot trigger internal RDS instance modification completion in lws")
