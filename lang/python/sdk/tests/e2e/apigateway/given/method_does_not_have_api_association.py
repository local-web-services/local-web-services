"""Given: the "api gateway" "method" does not have an "api gateway" "API" association"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "method" does not have an "api gateway" "API" association')
def method_does_not_have_api_association():
    pytest.skip("Cannot create a method without an API association in this abstract context")
