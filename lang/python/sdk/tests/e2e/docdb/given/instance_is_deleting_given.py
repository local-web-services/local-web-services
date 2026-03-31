"""Given: the "documentdb" "instance" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" was "DELETING"')
def instance_is_deleting_given():
    pytest.skip("Cannot observe DELETING instance state in lws")
