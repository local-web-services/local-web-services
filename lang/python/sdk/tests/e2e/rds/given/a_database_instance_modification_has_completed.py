"""Given: a database instance modification has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance modification has completed")
def a_database_instance_modification_has_completed():
    pytest.skip("Cannot trigger internal RDS instance modification completion in lws")
