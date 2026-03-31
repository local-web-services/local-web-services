"""Given: a "neptune" "instance" reboot completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "instance" reboot completes')
def neptune_database_instance_reboot_completed_seq():
    pytest.skip("Cannot trigger internal Neptune instance reboot completion in lws")
