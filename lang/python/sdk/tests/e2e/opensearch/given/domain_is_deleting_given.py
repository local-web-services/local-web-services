"""Given: the domain is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the domain is "DELETING"')
def domain_is_deleting_given():
    pytest.skip("Cannot observe DELETING domain state in lws")
