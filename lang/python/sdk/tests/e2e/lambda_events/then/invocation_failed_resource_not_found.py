"""Then: the invocation is "FAILED" with a ResourceNotFoundException"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "FAILED" with a ResourceNotFoundException')
def invocation_failed_resource_not_found(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")
