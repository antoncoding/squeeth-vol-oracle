<div align="center">
  <h1 align="center"> Squeeth Vol Oracle</h1>

<p align='center'>
    <!-- pics go here -->
    <img src='https://i.imgur.com/Qf6Ga0N.jpg' alt='squeeth' width="350" />
</p> 
<a href="https://github.com/antoncoding/squeeth-vol-oracle/actions/workflows/CI.yml"><img src="https://github.com/antoncoding/squeeth-vol-oracle/workflows/CI/badge.svg"> </a>

<h6 align="center"> Built with <a href="https://github.com/foundry-rs/forge-template"> foundry template</a>

</div>


## Deployments

The contract is deployed on Goerli and Mainnet:

| Chain | Address | 
| -------- | -------- |
| Mainnet    |   [0x5caec004f1378fbfd54a11e9f00e2aad32796b33](https://etherscan.io/address/0x5caec004f1378fbfd54a11e9f00e2aad32796b33#readContract)   |
| Goerli    |   [0x5caec004f1378fbfd54a11e9f00e2aad32796b33](https://goerli.etherscan.io/address/0x5caec004f1378fbfd54a11e9f00e2aad32796b33#readContract)  |

### Using the contract

You can use cast to directly query the value as follow (mainnet rpc example):

```
cast call 0x5caec004f1378fbfd54a11e9f00e2aad32796b33  "getEthTwaIV(uint32)(uint256)" 120 --rpc-url https://rpc.ankr.com/eth
```

## Development

### Getting Started

Compile and run tests

```sh
forge build

forge test
```


### Estimation

You can clone the contract, tune in a bit and use the following script to estimate real world vol value.

```shell
forge script scripts/Deploy.sol --fork-url <mainnet rpc>
```

Output:

```shell
== Logs ==
  implied volatility: 959347350657613352
  gas cost:           97612
  implied funding:    2521499559489813

```

#### Gas Cost

The gas cost is around 46K ~ 140K, depends on:

- `secondsAgo` to calculate twap
- current state of Uniswap pool, how many records are in the last `secondsAgo` seconds

It costs least (around 46K) while querying the implied vol by the current spot price.

### Contract Interface

```solidity
/// @dev return implied vol with 18 decimals (1e18 = 100%)
function getEthTwaIV(uint256 secondsAgo) external view returns (uint256 vol);

/// @dev return daily implied funding with 18 decimals (1e18 = 100%)
function getImpliedFunding(uint32 secondsAgo) external view returns (uint256 impliedFunding);

```
