const WEnFTLaunchpadFactory = artifacts.require("WenftLaunchpadFactory");
module.exports = function (_deployer, network, accounts) {
  console.log(`==> to ${network}`);
  // Use deployer to state migration tasks.
  _deployer.deploy(WEnFTLaunchpadFactory);
};
