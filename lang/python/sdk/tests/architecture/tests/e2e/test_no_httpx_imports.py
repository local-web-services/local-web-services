"""Wrapper: delegates to the shared lws_arch_tests implementation."""

from lws_arch_tests.e2e.test_no_httpx_imports import TestNoHttpxImports

__all__ = ["TestNoHttpxImports"]
