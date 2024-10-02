import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const ZrSignAppModule = buildModule("ZrSignAppModule", (m) => {
  const zrSignAddress = "0xA7AdF06a1D3a2CA827D4EddA96a1520054713E1c";

  // Deploy the SignTypes library
  // const zrSignTypes = m.library("SignTypes");

  // Link the SignTypes library to the zrSignCrossChainFaucetApp contract
  const zrSignApp = m.contract("ZrSignHelloWorld",[zrSignAddress], {
    // libraries: {
    //   SignTypes: zrSignTypes,
    // },
  });

  return { zrSignApp };
});

export default ZrSignAppModule;