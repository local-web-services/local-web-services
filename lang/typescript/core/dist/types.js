"use strict";
/** Shared type definitions for the TypeScript core. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.createServerState = createServerState;
function createServerState() {
    return {
        chaosRules: new Map(),
        fakeRules: new Map(),
        iamConfig: { enforce: false, identities: {}, resource_policies: {} },
        logBuffer: [],
        logSubscribers: new Set(),
        resetCallbacks: [],
    };
}
//# sourceMappingURL=types.js.map