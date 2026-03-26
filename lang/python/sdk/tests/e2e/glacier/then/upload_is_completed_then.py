"""Then: the upload is Completed and the assembled archive is "STORED" in the vault"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the upload is Completed and the assembled archive is "STORED" in the vault')
def upload_is_completed_then():
    pytest.skip("Cannot observe multipart upload completion in lws")
