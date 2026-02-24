from __future__ import annotations

from dataclasses import dataclass, field


@dataclass
class MockRoute:
    http_method: str
    resource_path: str
    handler_name: str


@dataclass
class MockFunction:
    logical_id: str
    handler: str
    environment: dict[str, str] = field(default_factory=dict)


@dataclass
class MockTable:
    logical_id: str
    table_name: str


@dataclass
class MockApi:
    logical_id: str
    routes: list[MockRoute] = field(default_factory=list)


@dataclass
class MockAppModel:
    functions: list[MockFunction] = field(default_factory=list)
    tables: list[MockTable] = field(default_factory=list)
    apis: list[MockApi] = field(default_factory=list)
