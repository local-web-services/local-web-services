"""Given: an archive retrieval job has been initiated"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an archive retrieval job has been initiated")
def glacier_seq_archive_retrieval_initiated():
    pytest.skip("Cannot initiate archive retrieval job without archive ID in lws")
