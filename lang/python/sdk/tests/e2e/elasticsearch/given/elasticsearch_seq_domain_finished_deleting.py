"""Given: an "elasticsearch" "domain" finishes deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticsearch" "domain" finishes deleting')
def elasticsearch_seq_domain_finished_deleting():
    pytest.skip("Cannot simulate domain deletion completion in lws")
