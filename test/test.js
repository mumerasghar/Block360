const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Block360", function () {

  let block;

  beforeEach(async function () {
    // different users to interact with contract
    // getting contact abi.
    const Block = await ethers.getContractFactory('Block');
    block = await Block.deploy();
    await block.deployed();
  });

  it("Add members", async function () {

    let user = await ethers.getSigners();

    await block.addMember('50', user[1].address);
    await block.addMember('25', user[2].address);
    const members = await block.getMembers();
    expect(members.length == 2);
  });

  it("Deposit Ether and distribure to members", async function () {
    let user = await ethers.getSigners();

    await block.addMember('50', user[1].address);
    await block.addMember('50', user[1].address);

    let usr0_bal = await block.balance(user[1].address);

    block.connect(user[3]).deposit({ value: ethers.utils.parseEther("4") });
    let u_bal = await block.balance(user[1].address);

    expect(usr0_bal + 4 == u_bal)

  })
});
