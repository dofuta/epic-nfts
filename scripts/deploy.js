const main = async () => {
  // Solidityファイルをコンパイルする
  const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNFTMultipleSVGs');

  // Hardhatによって小さいEthereumNetworkを構築し、かつSolidityファイルに書かれたスマートコントラクトを実行する
  const nftContract = await nftContractFactory.deploy();

  // 構築完了・スマートコントラクトのデプロイ完了の合図
  await nftContract.deployed();

  // コンソールにコントラクトアドレスを吐き出す。
  console.log("Contract deployed to:", nftContract.address);

  // 関数を実行する（NFTをミントする関数）
  let txn = await nftContract.makeAnEpicNFT()

  // NFTがミントされるまで待つ。
  await txn.wait()
  console.log("Minted NFT #1")

  // 2個目のNFTをミントしてみる（NFTをミントする関数）
  txn = await nftContract.makeAnEpicNFT()

  // NFTが民とされるまで待つ
  await txn.wait()
  console.log("Minted NFT #2")
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
