// SPDX-License-Identifier: BUSL
// SPDX-FileCopyrightText: 2024 Zenrock labs Ltd.

pragma solidity 0.8.19;

import {SignTypes} from "../libraries/SignTypes.sol";

interface ISign {
    function zrKeyReq(
        SignTypes.ZrKeyReqParams calldata params
    ) external payable;

    function zrKeyRes(SignTypes.ZrKeyResParams calldata params) external;

    function zrSignHash(
        SignTypes.ZrSignParams calldata params
    ) external payable;

    function zrSignData(
        SignTypes.ZrSignParams calldata params
    ) external payable;

    function zrSignTx(SignTypes.ZrSignParams calldata params) external payable;

    function zrSignSimpleTx(
        SignTypes.ZrSignParams memory params
    ) external payable;

    function zrSignRes(SignTypes.SignResParams calldata params) external;

    function version() external view returns (uint256);

    function isWalletTypeSupported(
        bytes32 walletTypeId
    ) external view returns (bool);

    function isChainIdSupported(
        bytes32 walletTypeId,
        bytes32 chainId
    ) external view returns (bool);

    function getWalletRegistry(
        bytes32 walletTypeId,
        uint256 walletIndex,
        address owner
    ) external view returns (SignTypes.WalletRegistry memory);

    function estimateFee(
        bytes32 walletTypeId,
        address owner,
        uint256 walletIndex,
        uint256 value
    ) external view returns (uint256 mpc, uint256 netResp, uint256 total);

    function estimateFee(
        uint8 monitoring,
        uint256 value
    ) external view returns (uint256 mpc, uint256 netResp, uint256 total);

    function getTraceId() external view returns (uint256);

    function getRequestState(
        uint256 traceId
    ) external view returns (SignTypes.ReqRegistry memory);

    function getMPCFee() external view returns (uint256);
    function getRespGas() external view returns (uint256);
    function getRespGasPriceBuffer() external view returns (uint256);

    function getZrKeys(
        bytes32 walletTypeId,
        address owner
    ) external view returns (string[] memory);

    function getZrKey(
        bytes32 walletTypeId,
        address owner,
        uint256 index
    ) external view returns (string memory);

    // Event declaration
    event ZrKeyRequest(
        bytes32 indexed walletTypeId,
        address indexed owner,
        uint256 indexed walletIndex,
        uint8 options
    );

    event ZrKeyResolve(
        bytes32 indexed walletTypeId,
        address indexed owner,
        uint256 indexed walletIndex,
        string addr
    );

    event ZrSigRequest(
        uint256 indexed traceId,
        bytes32 indexed walletId,
        SignTypes.SigReqParams params
    );

    event ZrSigResolve(
        uint256 indexed traceId,
        bytes metaData,
        bytes signature,
        bool broadcast
    );

    event MPCFeeUpdate(uint256 indexed oldBaseFee, uint256 indexed newBaseFee);
    event RespGasUpdate(uint256 indexed oldGas, uint256 indexed newGas);
    event RespGasPriceBufferUpdate(
        uint256 indexed oldGasPriceBuff,
        uint256 indexed newGasPriceBuff
    );

    event MPCFeeWithdraw(address indexed to, uint256 indexed amount);
}
