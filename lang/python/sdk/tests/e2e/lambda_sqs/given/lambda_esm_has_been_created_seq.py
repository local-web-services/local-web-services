"""Given: a Lambda event source mapping has been created linking a queue to a function"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a Lambda event source mapping has been created linking a queue to a function")
def lambda_esm_has_been_created_seq():
    pytest.skip("Cannot create an event source mapping in lws")
