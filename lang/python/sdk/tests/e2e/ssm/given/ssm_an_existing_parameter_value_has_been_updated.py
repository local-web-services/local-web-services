"""Given: an existing parameter value has been updated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient
from ..constants import TEST_PARAM, TEST_VALUE2


@given("an existing parameter value has been updated")
def ssm_an_existing_parameter_value_has_been_updated(lws_session):
    SsmTestClient(lws_session).put_parameter(
        Name=TEST_PARAM, Value=TEST_VALUE2, Type="String", Overwrite=True
    )
