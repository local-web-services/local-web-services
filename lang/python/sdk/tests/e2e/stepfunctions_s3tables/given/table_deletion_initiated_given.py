"""Given: a table deletion has been initiated"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a table deletion has been initiated")
def table_deletion_initiated_given():
    pytest.skip("Cannot pre-set an S3 Tables table deletion state for sequence setup")
