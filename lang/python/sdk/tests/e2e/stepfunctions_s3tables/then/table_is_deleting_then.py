"""Then: the table is "DELETING" and "SDK" task calls targeting it will fail"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the table is "DELETING" and "SDK" task calls targeting it will fail')
def table_is_deleting_then(lws_session):
    pytest.skip("Cannot observe S3 Tables table DELETING state in lws")
