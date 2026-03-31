"""Given: the tag did not exist on the "lambda" "function" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the tag did not exist on the "lambda" "function"')
def tag_does_not_exist_on_function():
    pytest.skip("Cannot verify that untag_resource fails for non-existent tags in lws")
