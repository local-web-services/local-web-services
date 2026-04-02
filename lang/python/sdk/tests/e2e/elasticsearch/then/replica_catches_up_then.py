"""Then: the "elasticsearch" "domain" replica will eventually catch up without changing document counts"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "elasticsearch" "domain" replica will eventually catch up without changing document counts'
)
def replica_catches_up_then():
    pytest.skip("Cannot observe internal replica sync state in lws")
