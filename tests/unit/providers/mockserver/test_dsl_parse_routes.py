"""Unit tests for parse_routes in DSL parser."""

from __future__ import annotations

from lws.providers.mockserver.dsl import parse_routes


class TestParseRoutes:
    def test_rest_route(self, tmp_path):
        # Arrange
        routes_dir = tmp_path / "routes"
        routes_dir.mkdir()
        route_file = routes_dir / "users.yaml"
        route_file.write_text(
            "routes:\n"
            "  - path: /v1/users\n"
            "    method: GET\n"
            "    responses:\n"
            "      - match: {}\n"
            "        status: 200\n"
            "        body:\n"
            "          users: []\n"
        )

        # Act
        parsed = parse_routes(routes_dir, "rest")

        # Assert
        assert len(parsed["routes"]) == 1
        expected_path = "/v1/users"
        actual_path = parsed["routes"][0].path
        assert actual_path == expected_path

    def test_graphql_route(self, tmp_path):
        # Arrange
        routes_dir = tmp_path / "routes"
        routes_dir.mkdir()
        route_file = routes_dir / "queries.yaml"
        route_file.write_text(
            "routes:\n"
            "  - operation: Query.user\n"
            "    match: {}\n"
            "    response:\n"
            "      data:\n"
            "        user:\n"
            "          id: '1'\n"
        )

        # Act
        parsed = parse_routes(routes_dir, "graphql")

        # Assert
        assert len(parsed["graphql_routes"]) == 1
        expected_op = "Query.user"
        actual_op = parsed["graphql_routes"][0].operation
        assert actual_op == expected_op

    def test_grpc_route(self, tmp_path):
        # Arrange
        routes_dir = tmp_path / "routes"
        routes_dir.mkdir()
        route_file = routes_dir / "methods.yaml"
        route_file.write_text(
            "routes:\n"
            "  - service: payment.PaymentService\n"
            "    method: GetPayment\n"
            "    match: {}\n"
            "    response:\n"
            "      fields:\n"
            "        id: pay_1\n"
        )

        # Act
        parsed = parse_routes(routes_dir, "grpc")

        # Assert
        assert len(parsed["grpc_routes"]) == 1
        expected_service = "payment.PaymentService"
        actual_service = parsed["grpc_routes"][0].service
        assert actual_service == expected_service

    def test_empty_routes_dir(self, tmp_path):
        # Arrange
        routes_dir = tmp_path / "routes"

        # Act
        parsed = parse_routes(routes_dir)

        # Assert
        assert len(parsed["routes"]) == 0

    def test_multiple_responses_ordered(self, tmp_path):
        # Arrange
        routes_dir = tmp_path / "routes"
        routes_dir.mkdir()
        route_file = routes_dir / "payments.yaml"
        route_file.write_text(
            "routes:\n"
            "  - path: /v1/payments/{id}\n"
            "    method: GET\n"
            "    responses:\n"
            "      - match:\n"
            "          path_params:\n"
            "            id: 'pay_expired_.*'\n"
            "        status: 410\n"
            "      - match: {}\n"
            "        status: 200\n"
        )

        # Act
        parsed = parse_routes(routes_dir, "rest")

        # Assert
        assert len(parsed["routes"][0].responses) == 2
        expected_first_status = 410
        actual_first_status = parsed["routes"][0].responses[0][1].status
        assert actual_first_status == expected_first_status
