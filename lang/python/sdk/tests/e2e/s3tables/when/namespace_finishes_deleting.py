"""When: a "s3 tables" "namespace" finishes being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "s3 tables" "namespace" finishes being deleted')
def namespace_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal namespace deletion completion in lws")
