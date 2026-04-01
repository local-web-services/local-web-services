"""Given: the "documentdb" "instance" was not already the primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" was not already the primary')
def instance_was_not_already_primary():
    pytest.skip("Cannot control primary instance assignment in lws")
