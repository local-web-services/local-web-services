"""Given: the "documentdb" "instance" was "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" was "CREATING"')
def instance_is_creating_given():
    pytest.skip("Cannot observe CREATING instance state in lws")
