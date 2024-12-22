// const hre = require("hardhat");

// async function main() {
//   const Upload = await hre.ethers.getContractFactory("Upload");
//   const upload = await Upload.deploy();

//   await upload.deployed();

//   console.log("Library deployed to:", upload.address);
// }

// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });



// const hre = require("hardhat");

// async function main() {
  
//   const upload = await hre.ethers.deployContract("Upload");
//   await upload.waitForDeployment();

//   console.log("Library deployed to:", upload.target);
// }

// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });

const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const Token = await ethers.getContractFactory("Token");
  const token = await Token.deploy();

  console.log("Token address:", token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });