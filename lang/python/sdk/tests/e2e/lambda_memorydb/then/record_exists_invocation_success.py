"""Then: the record "EXISTS" in the cluster and the invocation is "SUCCESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the record "EXISTS" in the cluster and the invocation is "SUCCESS"')
def record_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda record write result in lws")
