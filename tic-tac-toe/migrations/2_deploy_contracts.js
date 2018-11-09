var ttt = artifacts.require("./ttt.sol");
module.exports = function(deployer) {
  deployer.deploy(ttt);
};