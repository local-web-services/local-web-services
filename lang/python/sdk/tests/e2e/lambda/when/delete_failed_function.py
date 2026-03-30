"""When: a failed function is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a failed function is deleted")
def delete_failed_function(lws_session, world):
    pytest.skip("Cannot delete a FAILED Lambda function in lws (cannot reach FAILED state)")
