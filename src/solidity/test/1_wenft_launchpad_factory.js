const WenftLaunchpadFactory = artifacts.require("WenftLaunchpadFactory");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("WenftLaunchpadFactory", function (accounts) {
    let factory;
    let logs;
    const testAccount = accounts[0];

    const NULL_ADDRESS = "0x0000000000000000000000000000000000000000";

    it("should assert true", async function () {
        factory = await WenftLaunchpadFactory.deployed();
        return assert.isTrue(true);
    });

    it("generate launchpad set #1", async function () {
        const result = await factory.generateLaunchpadSet(
            "TESTNFT",
            "TNFT",
            "https://nftcontents.wenft.space/ASDF2/",
            true,
            testAccount, // accounts[1],
            NULL_ADDRESS
        );
        logs = result.receipt.logs;
        assert.isTrue(result.receipt.status);
        assert.isTrue(logs[0].args[0] !== NULL_ADDRESS);
        return;
    });

    it("get launchpad set #1", async function () {
        console.log(logs);
        const set = await factory.getLaunchpadSet(logs[0].args[0]);
        console.log("set:", set);
        assert.isTrue(set[0] !== NULL_ADDRESS);
        assert.isTrue(set[1] !== NULL_ADDRESS);
        assert.isTrue(set[2] !== NULL_ADDRESS);
        return;
    });

    it("generate launchpad set #2", async function () {
        const result = await factory.generateLaunchpadSet(
            "TESTNFT",
            "TNFT",
            "https://nftcontents.wenft.space/ASDF2/",
            true,
            testAccount, // accounts[1],
            NULL_ADDRESS
        );
        logs = result.receipt.logs;
        assert.isTrue(result.receipt.status);
        assert.isTrue(logs[0].args[0] !== NULL_ADDRESS);
        return;
    });

    it("get launchpad set #2", async function () {
        console.log(logs);
        const set = await factory.getLaunchpadSet(logs[0].args[0]);
        console.log("set:", set);
        assert.isTrue(set[0] !== NULL_ADDRESS);
        assert.isTrue(set[1] !== NULL_ADDRESS);
        assert.isTrue(set[2] !== NULL_ADDRESS);
        return;
    });
});
