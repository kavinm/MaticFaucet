// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const faucetContractFactory = await ethers.getContractFactory("KPMGFaucet");
  const faucetContract = await faucetContractFactory.deploy();
  await faucetContract.deployed();
  console.log("Contract deployed to: ", faucetContract.address);

  //donate funds to wallet
  let txn = await faucetContract.donateToFaucet({
    value: ethers.utils.parseEther(`0.05`),
  });
  await txn.wait();
  //console.log("Tx went through ", expect(tx.hash).to.not.be.undefined);

  //request funds from wallet
  let txn2 = await faucetContract.requestTokens(
    "0x5580565953b753cf00c6109546A4281d5b8c0ba3"
  );
  await txn2.wait();
  //console.log("Tx went through ", expect(tx.hash).to.not.be.undefined);

  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
