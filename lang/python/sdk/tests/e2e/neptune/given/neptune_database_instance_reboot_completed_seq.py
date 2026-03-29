"""Given: a database instance reboot has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance reboot has completed")
def neptune_database_instance_reboot_completed_seq():
    pytest.skip("Cannot trigger internal Neptune instance reboot completion in lws")
