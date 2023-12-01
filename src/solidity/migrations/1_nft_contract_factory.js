const NftContractFactory = artifacts.require("NftContractFactory");
module.exports = async function (_deployer, network, accounts) {
  console.log(`==> to ${network}`);
  // Use deployer to state migration tasks.
  await _deployer.deploy(NftContractFactory);

  const nftContractFactory = await NftContractFactory.deployed();
  console.log("   # NftContractFactory: ", nftContractFactory.address, "#");
};
