"""Then: the "rds" "instance" will be "AVAILABLE" again"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "rds" "instance" will be "AVAILABLE" again')
def instance_is_available_again_then(world):
    pytest.skip("Cannot observe RDS failover completion in lws")
