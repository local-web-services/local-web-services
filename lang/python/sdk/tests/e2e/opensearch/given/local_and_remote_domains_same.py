"""Given: the local and remote "opensearch" "domain"s are the same"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the local and remote "opensearch" "domain"s are the same')
def local_and_remote_domains_same():
    pytest.skip("Cannot create cross-cluster connection between same domain in lws")
