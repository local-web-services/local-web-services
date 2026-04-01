"""Then: a "rds" "snapshot" will be "CREATING" and the "rds" "instance" will be in "BACKING_UP" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'a "rds" "snapshot" will be "CREATING" and the "rds" "instance" will be in "BACKING_UP" state'
)
def snapshot_creating_and_instance_backing_up_then():
    pytest.skip("Cannot observe internal RDS backup state in lws")
