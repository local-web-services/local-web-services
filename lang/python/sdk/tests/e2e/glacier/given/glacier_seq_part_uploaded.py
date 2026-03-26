"""Given: a part has been uploaded for a multipart upload"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a part has been uploaded for a multipart upload")
def glacier_seq_part_uploaded():
    pytest.skip("Cannot upload a multipart part without an active upload ID in lws")
