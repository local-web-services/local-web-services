"use strict";
/** LwsManagementSdk — class-based management SDK for use in tests and tooling. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.LwsManagementSdk = void 0;
const cli_1 = require("./cli");
class LwsManagementSdk {
    constructor(port) {
        this.port = port;
        this.chaos = {
            enable: (service) => (0, cli_1.chaosEnable)(port, service),
            disable: (service) => (0, cli_1.chaosDisable)(port, service),
            set: (service, options) => (0, cli_1.chaosSet)(port, service, options),
            status: () => (0, cli_1.chaosStatus)(port),
        };
        this.iam = {
            set: (service, mode) => (0, cli_1.iamSet)(port, service, mode),
            disable: (service) => (0, cli_1.iamDisable)(port, service),
            setIdentity: (identity) => (0, cli_1.iamSetIdentity)(port, identity),
            registerIdentities: (identities) => (0, cli_1.iamRegisterIdentities)(port, identities),
            status: () => (0, cli_1.iamStatus)(port),
        };
    }
    async reset() {
        await (0, cli_1.reset)(this.port);
    }
}
exports.LwsManagementSdk = LwsManagementSdk;
//# sourceMappingURL=sdk.js.map