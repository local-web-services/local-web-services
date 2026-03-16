"use strict";
/** In-memory SQS queue implementation. */
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.LocalQueue = void 0;
const uuid_1 = require("uuid");
const crypto = __importStar(require("crypto"));
class LocalQueue {
    constructor(name, url, options = {}) {
        this._messages = [];
        this._dedupCache = new Map();
        this.name = name;
        this.url = url;
        this.visibilityTimeout = options.visibilityTimeout ?? 30;
        this.isFifo = options.isFifo ?? false;
        this.contentBasedDedup = options.contentBasedDedup ?? false;
        this.dlq = options.dlq;
        this.maxReceiveCount = options.maxReceiveCount ?? 0;
    }
    get messages() {
        return this._messages;
    }
    sendMessage(body, options = {}) {
        this._purgeDedupCache();
        let dedupId = options.messageDedupId;
        if (!dedupId && this.isFifo && this.contentBasedDedup) {
            dedupId = crypto.createHash("sha256").update(body).digest("hex");
        }
        if (dedupId) {
            const existing = this._messages.find((m) => m.messageDedupId === dedupId);
            if (existing)
                return existing.messageId;
        }
        const messageId = (0, uuid_1.v4)();
        const now = Date.now();
        const delayMs = (options.delaySeconds ?? 0) * 1000;
        const msg = {
            messageId,
            body,
            attributes: { ApproximateReceiveCount: "0" },
            messageAttributes: options.messageAttributes ?? {},
            receiptHandle: (0, uuid_1.v4)(),
            receiveCount: 0,
            sentTimestamp: now,
            visibilityTimeoutUntil: delayMs > 0 ? now + delayMs : 0,
            messageGroupId: options.messageGroupId,
            messageDedupId: dedupId,
        };
        this._messages.push(msg);
        if (dedupId) {
            this._dedupCache.set(dedupId, now + 5 * 60 * 1000); // 5-minute dedup window
        }
        return messageId;
    }
    receiveMessages(maxMessages = 1, waitTimeSeconds = 0) {
        void waitTimeSeconds; // long polling not supported in-memory (sync)
        const now = Date.now();
        const visible = this._messages.filter((m) => m.visibilityTimeoutUntil === 0 || m.visibilityTimeoutUntil <= now);
        const toReturn = visible.slice(0, maxMessages);
        const visTimeout = this.visibilityTimeout * 1000;
        for (const msg of toReturn) {
            msg.receiptHandle = (0, uuid_1.v4)();
            msg.receiveCount += 1;
            msg.attributes["ApproximateReceiveCount"] = String(msg.receiveCount);
            msg.visibilityTimeoutUntil = now + visTimeout;
            // DLQ routing
            if (this.dlq && this.maxReceiveCount > 0 && msg.receiveCount >= this.maxReceiveCount) {
                this.dlq.sendMessage(msg.body, { messageAttributes: msg.messageAttributes });
                this._messages = this._messages.filter((m) => m.messageId !== msg.messageId);
            }
        }
        return toReturn.filter((m) => this._messages.includes(m));
    }
    deleteMessage(receiptHandle) {
        this._messages = this._messages.filter((m) => m.receiptHandle !== receiptHandle);
    }
    changeMessageVisibility(receiptHandle, visibilityTimeoutSeconds) {
        const msg = this._messages.find((m) => m.receiptHandle === receiptHandle);
        if (msg) {
            msg.visibilityTimeoutUntil =
                visibilityTimeoutSeconds === 0 ? 0 : Date.now() + visibilityTimeoutSeconds * 1000;
        }
    }
    purge() {
        this._messages = [];
        this._dedupCache.clear();
    }
    approximateMessageCount() {
        const now = Date.now();
        return this._messages.filter((m) => m.visibilityTimeoutUntil === 0 || m.visibilityTimeoutUntil <= now).length;
    }
    _purgeDedupCache() {
        const now = Date.now();
        for (const [key, expiry] of this._dedupCache) {
            if (expiry <= now)
                this._dedupCache.delete(key);
        }
    }
}
exports.LocalQueue = LocalQueue;
//# sourceMappingURL=queue.js.map