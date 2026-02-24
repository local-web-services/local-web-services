"""Pytest fixtures for LWS testing.

Registered automatically via the ``pytest11`` entry point — no import required.

Available fixtures
------------------
``lws_session``
    Session-scoped fixture that starts a :class:`~lws_testing.LwsSession`
    once per test session.  Override ``lws_session_spec`` to configure it.

``lws_reset``
    Function-scoped autouse fixture that calls :meth:`~lws_testing.LwsSession.reset`
    between every test so each test starts with a clean slate.

``lws_session_spec``
    Session-scoped fixture that returns the resource spec passed to
    :class:`~lws_testing.LwsSession`.  Override in your ``conftest.py``::

        @pytest.fixture(scope="session")
        def lws_session_spec():
            return {
                "tables": [{"name": "Orders", "partition_key": "id"}],
                "queues": ["OrderQueue"],
            }
"""

from __future__ import annotations

from collections.abc import Generator
from typing import Any

import pytest

from lws_testing.session import LwsSession


@pytest.fixture(scope="session")
def lws_session_spec() -> dict[str, Any]:
    """Override this fixture to provide explicit resource declarations.

    Alternatively use ``lws_session_from_cdk`` or ``lws_session_from_hcl``
    fixtures instead.
    """
    return {}


@pytest.fixture(scope="session")
def lws_session(lws_session_spec: dict[str, Any]) -> Generator[LwsSession, None, None]:
    """Session-scoped LwsSession — starts once, shared across all tests."""
    with LwsSession(**lws_session_spec) as session:
        yield session


@pytest.fixture(scope="session")
def lws_session_from_cdk(cdk_project_dir: str = ".") -> Generator[LwsSession, None, None]:
    """Session-scoped LwsSession discovered from a CDK project.

    Override the ``cdk_project_dir`` fixture to customise the project path.
    """
    with LwsSession.from_cdk(cdk_project_dir) as session:
        yield session


@pytest.fixture(scope="session")
def lws_session_from_hcl(hcl_project_dir: str = ".") -> Generator[LwsSession, None, None]:
    """Session-scoped LwsSession discovered from a Terraform/HCL project.

    Override the ``hcl_project_dir`` fixture to customise the project path.
    """
    with LwsSession.from_hcl(hcl_project_dir) as session:
        yield session


@pytest.fixture(scope="session")
def cdk_project_dir() -> str:
    """Path to the CDK project root. Override in conftest.py."""
    return "."


@pytest.fixture(scope="session")
def hcl_project_dir() -> str:
    """Path to the directory containing .tf files. Override in conftest.py."""
    return "."


@pytest.fixture
def lws_reset(lws_session: LwsSession) -> None:
    """Reset all service state before a test.

    Include this fixture in your test or add it as autouse in ``conftest.py``::

        # conftest.py
        @pytest.fixture(autouse=True)
        def reset(lws_reset):
            pass

    It calls :meth:`~lws_testing.LwsSession.reset` which clears DynamoDB
    tables, SQS queues, S3 buckets, and other service state.
    """
    lws_session.reset()
