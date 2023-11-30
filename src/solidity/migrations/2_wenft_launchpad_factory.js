const WEnFTLaunchpadFactory = artifacts.require("WenftLaunchpadFactory");
module.exports = async function (_deployer, network, accounts) {
  console.log(`==> to ${network}`);
  // Use deployer to state migration tasks.
  await _deployer.deploy(WEnFTLaunchpadFactory);
};
