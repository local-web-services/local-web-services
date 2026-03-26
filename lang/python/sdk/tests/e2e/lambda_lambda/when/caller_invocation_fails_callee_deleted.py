"""When: the caller fails to invoke the callee because the callee has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the caller fails to invoke the callee because the callee has been deleted")
def caller_invocation_fails_callee_deleted(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
