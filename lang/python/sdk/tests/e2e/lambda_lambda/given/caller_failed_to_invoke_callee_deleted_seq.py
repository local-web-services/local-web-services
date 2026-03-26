"""Given: the caller has failed to invoke the callee because the callee has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the caller has failed to invoke the callee because the callee has been deleted")
def caller_failed_to_invoke_callee_deleted_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")
