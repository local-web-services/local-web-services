"""Given: the "s3 tables" "bucket" had active namespaces"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "bucket" had active namespaces')
def bucket_has_active_namespaces():
    pytest.skip(
        "Emulator does not enforce bucket-deletion-requires-no-namespaces constraint in "
        "integration context"
    )
