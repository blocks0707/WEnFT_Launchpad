const NftContract = artifacts.require("NftContract");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("NftContract", function (/* accounts */) {
  it("should assert true", async function () {
    await NftContract.deployed();
    return assert.isTrue(true);
  });
});
