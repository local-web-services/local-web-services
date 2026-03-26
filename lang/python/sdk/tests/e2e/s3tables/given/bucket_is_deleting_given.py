"""Given: the bucket is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the bucket is "DELETING"')
def bucket_is_deleting_given():
    pytest.skip("Cannot observe DELETING bucket state in lws")
