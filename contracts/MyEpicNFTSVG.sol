// SPDX-License-Identifier: UNLICENSED

// 継承の仕組み。is で カンマの右が優先される。
// https://solidity-by-example.org/inheritance/

// NFT の 標準 ライブラリ OpenZeppelin の ERC721
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol

// ERC721に URIStorageがついたやつ。今回はこれを利用する。
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol

// Solidity の Global Variables
// https://docs.soliditylang.org/en/develop/units-and-global-variables.html#block-and-transaction-properties

// OpenSeaの Metadata の決まり事。これに従ってmetadataを作らないと、OpenSea上に変なふうに表示されてしまう。
// https://docs.opensea.io/docs/metadata-standards

// OpenSea準拠のメタデータの一例
// {
//   "description": "Friendly OpenSea Creature that enjoys long swims in the ocean.",
//   "external_url": "https://openseacreatures.io/3",
//   "image": "https://storage.googleapis.com/opensea-prod.appspot.com/puffs/3.png",
//   "name": "Dave Starbelly",
//   "attributes": [ ... ],
// }

pragma solidity ^0.8.0;

// OpenZeppelinのSolidityファイルをインポートしてくる
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";


// コントラクト（Solidityファイル）から、関数を利用するために、継承する。ERC721URIStorageという
contract MyEpicNFTSVG is ERC721URIStorage {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;

  // private _tokneIds と宣言すると、自動で0からインクリメントするユニークなIDを生成してくれる。
  // _tokenIdsはステート変数で、これを変更すると値が直接コントラクトに保存されます。
  Counters.Counter private _tokenIds;


  constructor() ERC721 ("Dofuku NFT", "DOFUKU") {
    console.log("This is my NFT contract. Woah!");
  }

  // A function our user will hit to get their NFT.
  function makeAnEpicNFT() public {

     // 現在の_tokenIdsを取得する。最初は0から始まる。
    uint256 newItemId = _tokenIds.current();

    // Actually mint the NFT to the sender using msg.sender.
	// msg.sender = 発行者のアドレスが入っているらしい。Solidityが提供してくれるグローバル変数
	// つまり、ログインしないとこのSolidityで書かれたスマートコントラクトは実行できないということでもある。
    _safeMint(msg.sender, newItemId);

    // Set the NFTs data. ここではblahの文字列をNFTの実態データとして登録します。通常は、ここにURLが入ったり、画像データが入ったり、します。
    _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiRXBpY0xvcmRIYW1idXJnZXIiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSBoaWdobHkgYWNjbGFpbWVkIHNxdWFyZSBjb2xsZWN0aW9uIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0TkNpQWdJQ0E4YzNSNWJHVStMbUpoYzJVZ2V5Qm1hV3hzT2lCM2FHbDBaVHNnWm05dWRDMW1ZVzFwYkhrNklITmxjbWxtT3lCbWIyNTBMWE5wZW1VNklERTBjSGc3SUgwOEwzTjBlV3hsUGcwS0lDQWdJRHh5WldOMElIZHBaSFJvUFNJeE1EQWxJaUJvWldsbmFIUTlJakV3TUNVaUlHWnBiR3c5SW1Kc1lXTnJJaUF2UGcwS0lDQWdJRHgwWlhoMElIZzlJalV3SlNJZ2VUMGlOVEFsSWlCamJHRnpjejBpWW1GelpTSWdaRzl0YVc1aGJuUXRZbUZ6Wld4cGJtVTlJbTFwWkdSc1pTSWdkR1Y0ZEMxaGJtTm9iM0k5SW0xcFpHUnNaU0krUlhCcFkweHZjbVJJWVcxaWRYSm5aWEk4TDNSbGVIUStEUW84TDNOMlp6ND0iCn0=");

	// 試しに色々SpecialVariablesを吐き出してみる。
	console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
	// console.log("(uint): current blocks base fee (EIP-3198 and EIP-1559): ", block.basefee);
	console.log("(uint): current chain id: ", block.chainid);
	console.log("(address payable): current block miners address: ", block.coinbase);
	console.log("(uint): current block difficulty: ", block.difficulty);
	console.log("(uint): current block gaslimit: ", block.gaslimit);
	console.log("(uint): current block number: ", block.number);
	console.log("(uint): current block timestamp as seconds since unix epoch: ", block.timestamp);
	console.log("(uint256): remaining gas: ", gasleft());
	// console.log("(bytes calldata): complete calldata: ", msg.data);
	console.log("(address): sender of the message); (current call): ", msg.sender);
	// console.log("(bytes4): first four bytes of the calldata) (i.e. function identifier): ", msg.sig);
	// console.log("(uint): number of wei sent with the message: ", msg.value);
	console.log("(uint): gas price of the transaction: ", tx.gasprice);
	console.log("(address): sender of the transaction (full call chain): ", tx.origin);

    // _tokenIdsをインクリメントさせる。increment()は、OpenZeppelinのライブラリが提供してくれている関数。
    _tokenIds.increment();
  }
}
