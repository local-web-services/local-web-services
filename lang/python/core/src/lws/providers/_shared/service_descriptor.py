"""Self-registration descriptor for simple AWS service providers.

A simple service is one whose factory accepts at most ``chaos``, ``aws_fake``,
and ``context`` keyword arguments and returns a ``(FastAPI, Any)`` tuple.
Complex services (those requiring cross-provider wiring, container managers,
or tracker registries) are not described here.
"""

from __future__ import annotations

import importlib
import pkgutil
from collections.abc import Callable
from dataclasses import dataclass
from typing import Any

from fastapi import FastAPI

import lws.providers


@dataclass(frozen=True)
class ServiceDescriptor:
    """Describes a simple service that can be auto-discovered."""

    name: str
    factory: Callable[..., tuple[FastAPI, Any]]


def discover_simple_services() -> list[ServiceDescriptor]:
    """Scan ``lws.providers.*`` subpackages for ``DESCRIPTOR`` attributes.

    Returns descriptors sorted alphabetically by service name.
    Import errors propagate rather than being silently suppressed.
    """
    descriptors: list[ServiceDescriptor] = []
    for _, mod_name, is_pkg in pkgutil.iter_modules(lws.providers.__path__, "lws.providers."):
        if not is_pkg:
            continue
        try:
            mod = importlib.import_module(f"{mod_name}.routes")
        except ModuleNotFoundError:
            continue
        descriptor = getattr(mod, "DESCRIPTOR", None)
        if descriptor is not None:
            descriptors.append(descriptor)
    return sorted(descriptors, key=lambda d: d.name)
