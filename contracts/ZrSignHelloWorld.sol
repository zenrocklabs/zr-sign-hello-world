// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {ZrSignConnect} from "./zrSignConnect.sol";

import {Strings} from "./libraries/Strings.sol";

contract ZrSignHelloWorld is ZrSignConnect {
    constructor(address payable zrSignAddress) ZrSignConnect(zrSignAddress) {}

    function signMessage(
        string memory message,
        uint256 walletIndex,
        bytes32 dstChainId
    ) external payable {
        // Prefix the message with "\x19Ethereum Signed Message:\n" and the length of the message
        bytes32 prefixedHash = keccak256(
            abi.encodePacked(
                "\x19Ethereum Signed Message:\n",
                Strings.toString(bytes(message).length),
                message
            )
        );

        reqSignForHash(EVM_WALLET_TYPE, walletIndex, dstChainId, prefixedHash);
    }

    function transfer(
        address to,
        uint256 value,
        bytes memory data,
        uint256 nonce,
        uint256 gasPrice,
        uint256 gasLimit,
        uint256 walletIndex,
        bytes32 dstChainId
    ) external payable {
        bytes memory payload = rlpEncodeTransaction(
            nonce,
            gasPrice,
            gasLimit,
            to,
            value,
            data
        );

        reqSignForTx(EVM_WALLET_TYPE, walletIndex, dstChainId, payload, true);
    }
}
