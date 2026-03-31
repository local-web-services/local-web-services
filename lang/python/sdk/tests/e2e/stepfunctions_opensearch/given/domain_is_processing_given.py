"""Given: the "opensearch" "domain" was "PROCESSING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "domain" was "PROCESSING"')
def domain_is_processing_given(lws_session, world):
    pytest.skip("Cannot put an OpenSearch domain into PROCESSING state in lws")
