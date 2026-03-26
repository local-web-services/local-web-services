"""Given: a database instance has been rebooted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance has been rebooted")
def neptune_database_instance_rebooted_seq():
    pytest.skip("Cannot trigger internal Neptune instance reboot in lws")
