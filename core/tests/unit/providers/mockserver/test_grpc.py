"""Unit tests for mock server gRPC handler."""

from __future__ import annotations

from lws.providers.mockserver.grpc_handler import match_grpc_request
from lws.providers.mockserver.models import GrpcRoute


class TestMatchGrpcRequest:
    def test_catch_all_match(self):
        # Arrange
        route = GrpcRoute(
            service="payment.PaymentService",
            method="GetPayment",
            match={},
            response={"fields": {"id": "pay_1", "amount": 4999}},
        )
        service = "payment.PaymentService"
        method = "GetPayment"

        # Act
        result = match_grpc_request([route], service, method, {})

        # Assert
        assert result is not None
        expected_id = "pay_1"
        actual_id = result["fields"]["id"]
        assert actual_id == expected_id

    def test_field_match(self):
        # Arrange
        route_specific = GrpcRoute(
            service="payment.PaymentService",
            method="GetPayment",
            match={"fields": {"payment_id": "pay_notfound"}},
            response={"status_code": "NOT_FOUND", "message": "Payment not found"},
        )
        route_default = GrpcRoute(
            service="payment.PaymentService",
            method="GetPayment",
            match={},
            response={"fields": {"id": "pay_1"}},
        )

        # Act
        result = match_grpc_request(
            [route_specific, route_default],
            "payment.PaymentService",
            "GetPayment",
            {"payment_id": "pay_notfound"},
        )

        # Assert
        assert result is not None
        expected_code = "NOT_FOUND"
        actual_code = result["status_code"]
        assert actual_code == expected_code

    def test_no_match_wrong_service(self):
        # Arrange
        route = GrpcRoute(
            service="payment.PaymentService",
            method="GetPayment",
            match={},
            response={"fields": {}},
        )

        # Act
        result = match_grpc_request([route], "order.OrderService", "GetOrder", {})

        # Assert
        assert result is None

    def test_no_match_wrong_method(self):
        # Arrange
        route = GrpcRoute(
            service="payment.PaymentService",
            method="GetPayment",
            match={},
            response={"fields": {}},
        )

        # Act
        result = match_grpc_request([route], "payment.PaymentService", "CreatePayment", {})

        # Assert
        assert result is None

    def test_template_rendering(self):
        # Arrange
        route = GrpcRoute(
            service="payment.PaymentService",
            method="GetPayment",
            match={},
            response={"fields": {"id": "{{request.payment_id}}", "amount": 4999}},
        )

        # Act
        result = match_grpc_request(
            [route],
            "payment.PaymentService",
            "GetPayment",
            {"payment_id": "pay_abc"},
        )

        # Assert
        expected_id = "pay_abc"
        actual_id = result["fields"]["id"]
        assert actual_id == expected_id
