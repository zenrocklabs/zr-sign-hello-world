import { ignition, run, ethers } from "hardhat";
import ZrSignAppModule from "../ignition/modules/ZrSignApp";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const zrSignAddress = "0xA7AdF06a1D3a2CA827D4EddA96a1520054713E1c";
  const { zrSignApp } = await ignition.deploy(ZrSignAppModule);

  console.log("zrSignCrossChainFaucetApp deployed to:", zrSignApp.target);

  // Verify the contract after deployment
  await run("verify:verify", {
    address: zrSignApp.target,
    constructorArguments: [zrSignAddress],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});