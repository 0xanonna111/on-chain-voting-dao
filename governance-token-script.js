// Deployment helper for a basic governance token
async function deployGovernance() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying with:", deployer.address);

  const GovernanceToken = await ethers.getContractFactory("ERC20Mock");
  const token = await GovernanceToken.deploy("GovToken", "GTK", deployer.address, 1000000);
  
  const DAO = await ethers.getContractFactory("SimpleDAO");
  const dao = await DAO.deploy(token.target);

  console.log("DAO Contract Address:", dao.target);
}
