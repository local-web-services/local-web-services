"""Given: a namespace has finished being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a namespace has finished being deleted")
def s3tables_a_namespace_has_finished_being_deleted():
    pytest.skip("Cannot trigger internal namespace deletion completion in lws")
