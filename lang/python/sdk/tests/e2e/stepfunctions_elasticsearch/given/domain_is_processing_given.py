"""Given: the domain is "PROCESSING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the domain is "PROCESSING"')
def domain_is_processing_given(lws_session, world):
    pytest.skip("Cannot put an Elasticsearch domain into PROCESSING state in lws")
