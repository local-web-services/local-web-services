"""Then: the "rds" "instance" returns to "AVAILABLE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "rds" "instance" returns to "AVAILABLE" state')
def instance_returns_to_available_then():
    pytest.skip("Cannot observe internal instance state transition in lws")
