"""Given: a multipart upload has been initiated for a vault"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a multipart upload has been initiated for a vault")
def glacier_seq_multipart_upload_initiated():
    pytest.skip("Multipart upload is not supported by the lws glacier provider")
