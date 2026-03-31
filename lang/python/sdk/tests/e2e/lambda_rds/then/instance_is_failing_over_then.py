"""Then: the "rds" "instance" will be "FAILING_OVER" and temporarily unavailable for connections"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "rds" "instance" will be "FAILING_OVER" and temporarily unavailable for connections')
def instance_is_failing_over_then(world):
    pytest.skip("Cannot observe RDS failover state in lws")
