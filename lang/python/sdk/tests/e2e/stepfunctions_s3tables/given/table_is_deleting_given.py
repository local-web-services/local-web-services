"""Given: the table is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table is "DELETING"')
def table_is_deleting_given(lws_session, world):
    pytest.skip("Cannot put an S3 Tables table into DELETING state in lws")
