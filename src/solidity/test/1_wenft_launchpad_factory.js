const WenftLaunchpadFactory = artifacts.require("WenftLaunchpadFactory");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("WenftLaunchpadFactory", function (accounts) {
  let factory;
  let logs;

  it("should assert true", async function () {
    factory = await WenftLaunchpadFactory.deployed();
    return assert.isTrue(true);
  });

  it("generate launchpad set", async function () {
    const receipt = await factory.generateLaunchpadSet(
      "TESTNFT",
      "TNFT",
      "https://nftcontents.wenft.space/ASDF2/",
      "https://nftcontents.wenft.space/JJD/",
      accounts[1]
    );
    logs = receipt.logs;
    return assert.isTrue(true);
  });

  it("get launchpad set", async function () {
    console.log(logs);
    const set = await factory.getLaunchpadSet(logs[0].args[0]);
    console.log("set:", set);
    return assert.isTrue(true);
  });
});
