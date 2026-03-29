"""Then: the snapshot is "CREATING" and the instance is in "BACKING_UP" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the snapshot is "CREATING" and the instance is in "BACKING_UP" state')
def snapshot_creating_instance_backing_up_then():
    pytest.skip("Cannot observe internal RDS backup state in lws")
