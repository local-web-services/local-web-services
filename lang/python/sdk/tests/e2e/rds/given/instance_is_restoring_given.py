"""Given: the instance is "RESTORING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance is "RESTORING"')
def instance_is_restoring_given():
    pytest.skip("Cannot observe RESTORING instance state in lws")
