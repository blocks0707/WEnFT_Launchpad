const MintContract = artifacts.require("MintContract");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("MintContract", function (/* accounts */) {
  it("should assert true", async function () {
    await MintContract.deployed();
    return assert.isTrue(true);
  });
});
