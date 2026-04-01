"""Given: the "documentdb" "instance" was not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" was not "AVAILABLE"')
def instance_is_not_available_given():
    pytest.skip("Cannot control instance availability state in lws")
