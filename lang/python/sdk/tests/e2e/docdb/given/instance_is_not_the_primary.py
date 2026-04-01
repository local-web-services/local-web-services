"""Given: the "documentdb" "instance" is not the primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" is not the primary')
def instance_is_not_the_primary():
    pytest.skip("Cannot control primary instance assignment in lws")
