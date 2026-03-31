"""Then: the "memorydb" "ACL" returns to "ACTIVE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "memorydb" "ACL" returns to "ACTIVE" state')
def acl_returns_to_active_then():
    pytest.skip("Cannot observe internal ACL state transition in lws")
