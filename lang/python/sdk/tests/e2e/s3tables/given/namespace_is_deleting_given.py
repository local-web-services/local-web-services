"""Given: the namespace is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the namespace is "DELETING"')
def namespace_is_deleting_given():
    pytest.skip("Cannot observe DELETING namespace state in lws")
