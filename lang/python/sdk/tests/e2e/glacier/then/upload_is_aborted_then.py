"""Then: the upload is Aborted"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the upload is Aborted")
def upload_is_aborted_then():
    pytest.skip("Cannot observe multipart upload abort in lws")
