// 実行
// npx hardhat run scripts/run.js

// hre = The Hardhat Runtime Environment
// npx hardhat run することで、hardhatがhreを読み込む。
// そのため、const hardhat = require("hardhat")のように、hreをインポートしていなくても使える。


const main = async () => {

  // Solidityファイルをコンパイルする
  const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNFTTest');

  // Hardhatによって小さいEthereumNetworkを構築し、かつSolidityファイルに書かれたスマートコントラクトを実行する
  const nftContract = await nftContractFactory.deploy();

  // 構築完了・スマートコントラクトのデプロイ完了の合図
  await nftContract.deployed();

  // コンソールにコントラクトアドレスを吐き出す。
  console.log("Contract deployed to:", nftContract.address);
}

const runMain = async() => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
