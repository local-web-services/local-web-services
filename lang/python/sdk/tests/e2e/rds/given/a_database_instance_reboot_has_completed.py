"""Given: a database instance reboot has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance reboot has completed")
def a_database_instance_reboot_has_completed():
    pytest.skip("Cannot trigger internal RDS instance reboot completion in lws")
