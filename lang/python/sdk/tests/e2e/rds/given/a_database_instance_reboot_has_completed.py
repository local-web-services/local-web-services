"""Given: a "rds" "instance" reboot completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "instance" reboot completes')
def a_database_instance_reboot_has_completed():
    pytest.skip("Cannot trigger internal RDS instance reboot completion in lws")
