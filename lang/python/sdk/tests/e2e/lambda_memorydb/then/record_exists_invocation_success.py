"""Then: the record will exist in the "memorydb" "cluster" and the invocation will be "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the record will exist in the "memorydb" "cluster" and the invocation will be "SUCCESS"')
def record_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda record write result in lws")
