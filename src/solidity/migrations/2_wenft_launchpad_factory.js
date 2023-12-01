const NftContractFactory = artifacts.require("NftContractFactory");
const WEnFTLaunchpadFactory = artifacts.require("WenftLaunchpadFactory");
module.exports = async function (_deployer, network, accounts) {
  console.log(`==> to ${network}`);
  // Use deployer to state migration tasks.
  await _deployer.deploy(WEnFTLaunchpadFactory);

  const wenftLaunchpadFactory = await WEnFTLaunchpadFactory.deployed();
  if (!!wenftLaunchpadFactory) {
    console.log(
      "   # wenftLaunchpadFactory: ",
      wenftLaunchpadFactory.address,
      "#"
    );
    const nftContractFactory = await NftContractFactory.deployed();
    await wenftLaunchpadFactory.setFactoryContract(nftContractFactory.address);
    console.log(
      "   #    setFactoryContract: ",
      nftContractFactory.address,
      "#"
    );
  }
};
